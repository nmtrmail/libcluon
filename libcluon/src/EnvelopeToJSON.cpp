/*
 * Copyright (C) 2017  Christian Berger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "cluon/EnvelopeToJSON.hpp"

#include "cluon/GenericMessage.hpp"
#include "cluon/JSONVisitor.hpp"
#include "cluon/MessageFromProtoDecoder.hpp"
#include "cluon/MessageParser.hpp"
#include <algorithm>
#include <sstream>

namespace cluon {

int32_t EnvelopeToJSON::setMessageSpecification(const std::string &ms) noexcept {
    int32_t retVal{-1};

    m_listOfMetaMessages.clear();
    m_scopeOfMetaMessages.clear();

    cluon::MessageParser mp;
    auto parsingResult = mp.parse(ms);
    if (cluon::MessageParser::MessageParserErrorCodes::NO_ERROR == parsingResult.second) {
        m_listOfMetaMessages = parsingResult.first;
        for (const auto &mm : m_listOfMetaMessages) { m_scopeOfMetaMessages[mm.messageIdentifier()] = mm; }
        retVal = static_cast<int32_t>(m_listOfMetaMessages.size());
    }
    return retVal;
}

std::string EnvelopeToJSON::getJSONFromProtoEncodedEnvelope(const std::string &protoEncodedEnvelope) noexcept {
    std::string retVal{"{}"};
    if (!m_listOfMetaMessages.empty()) {
        constexpr uint8_t OD4_HEADER_SIZE{5};
        if (OD4_HEADER_SIZE <= protoEncodedEnvelope.size()) {
            // First, test for OD4-header that might be optional.
            char byte0{protoEncodedEnvelope.at(0)};
            char byte1{protoEncodedEnvelope.at(1)};
            uint32_t length{0};
            {
                std::stringstream sstr{std::string(&protoEncodedEnvelope[1], 4)};
                sstr.read(reinterpret_cast<char *>(&length), sizeof(uint32_t)); // NOLINT
                length = le32toh(length);
                length >>= 8;
            }
            std::string input{protoEncodedEnvelope};
            if ((0x0D == static_cast<uint8_t>(byte0)) && (0xA4 == static_cast<uint8_t>(byte1))
                && (length == protoEncodedEnvelope.size() - OD4_HEADER_SIZE)) {
                input = protoEncodedEnvelope.substr(OD4_HEADER_SIZE);
            }

            cluon::data::Envelope env;

            std::stringstream sstr{input};
            cluon::MessageFromProtoDecoder protoDecoder;
            protoDecoder.decodeFrom(sstr);
            env.accept(protoDecoder);

            retVal = getJSONFromEnvelope(env);
        }
    }
    return retVal;
}

std::string EnvelopeToJSON::getJSONFromEnvelope(cluon::data::Envelope &envelope) noexcept {
    std::string retVal{"{}"};
    if (!m_listOfMetaMessages.empty()) {
        if (0 < m_scopeOfMetaMessages.count(static_cast<uint32_t>(envelope.dataType()))) {
            // First, create JSON from Envelope.
            constexpr bool OUTER_CURLY_BRACES{false};
            // Ignore field 2 (= serializedData) as it will be replaced below.
            const std::map<uint32_t, bool> mask{{2, false}};
            JSONVisitor jsonFromEnvelope{OUTER_CURLY_BRACES, mask};
            envelope.accept(jsonFromEnvelope);

            std::stringstream sstr{envelope.serializedData()};
            cluon::MessageFromProtoDecoder protoDecoder;
            protoDecoder.decodeFrom(sstr);

            // Now, create JSON from payload.
            cluon::MetaMessage payload{m_scopeOfMetaMessages[static_cast<uint32_t>(envelope.dataType())]};
            cluon::GenericMessage gm;
            gm.setMetaMessage(payload, m_listOfMetaMessages, protoDecoder);

            JSONVisitor jsonFromPayload{OUTER_CURLY_BRACES};
            gm.accept(jsonFromPayload);

            std::string tmp{payload.messageName()};
            std::replace(tmp.begin(), tmp.end(), '.', '_');

            retVal = '{' + jsonFromEnvelope.json() + ',' + '\n' + '"' + tmp + '"' + ':' + '{'
                     + jsonFromPayload.json() + '}' + '}';
        }
    }
    return retVal;
}

} // namespace cluon
