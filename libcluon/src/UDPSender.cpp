/*
 * Copyright (C) 2017-2018  Christian Berger
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "cluon/UDPSender.hpp"
#include "cluon/UDPPacketSizeConstraints.hpp"

// clang-format off
#ifdef WIN32
    #include <iostream>
#else
    #include <arpa/inet.h>
    #include <sys/socket.h>
    #include <sys/types.h>
    #include <unistd.h>
#endif
// clang-format on

#include <cerrno>
#include <cstring>
#include <algorithm>
#include <iterator>
#include <sstream>
#include <vector>

namespace cluon {

UDPSender::UDPSender(const std::string &sendToAddress, uint16_t sendToPort) noexcept
    : m_socketMutex()
    , m_sendToAddress() {
    // Decompose given address into tokens to check validity with numerical IPv4 address.
    std::string tmp{sendToAddress};
    std::replace(tmp.begin(), tmp.end(), '.', ' ');
    std::istringstream sstr{tmp};
    std::vector<int> sendToAddressTokens{std::istream_iterator<int>(sstr), std::istream_iterator<int>()};

    if (!sendToAddress.empty() && (4 == sendToAddressTokens.size())
        && !(std::end(sendToAddressTokens) != std::find_if(sendToAddressTokens.begin(), sendToAddressTokens.end(), [](int a) { return (a < 0) || (a > 255); }))
        && (0 < sendToPort)) {
        ::memset(&m_sendToAddress, 0, sizeof(m_sendToAddress));
        m_sendToAddress.sin_addr.s_addr = ::inet_addr(sendToAddress.c_str());
        m_sendToAddress.sin_family      = AF_INET;
        m_sendToAddress.sin_port        = htons(sendToPort);

#ifdef WIN32
        // Load Winsock 2.2 DLL.
        WSADATA wsaData;
        if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0) {
            std::cerr << "[cluon::UDPSender] Error while calling WSAStartUp: " << WSAGetLastError() << std::endl;
        }
#endif

        m_socket = ::socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);

        // Bind to random address/port but store sender port.
        if (!(m_socket < 0)) {
            struct sockaddr_in sendFromAddress;
            std::memset(&sendFromAddress, 0, sizeof(sendFromAddress));
            sendFromAddress.sin_family = AF_INET;
            sendFromAddress.sin_port   = 0;                                                                              // Randomly choose a port to bind.
            if (0 == ::bind(m_socket, reinterpret_cast<struct sockaddr *>(&sendFromAddress), sizeof(sendFromAddress))) { // NOLINT
                struct sockaddr tmpAddr;
                socklen_t length = sizeof(tmpAddr);
                if (0 == ::getsockname(m_socket, &tmpAddr, &length)) {
                    struct sockaddr_in tmpAddrIn;
                    std::memcpy(&tmpAddrIn, &tmpAddr, sizeof(tmpAddrIn)); /* Flawfinder: ignore */ // NOLINT
                    m_portToSentFrom = ntohs(tmpAddrIn.sin_port);
                }
            }
        }

#ifdef WIN32
        if (m_socket < 0) {
            std::cerr << "[cluon::UDPSender] Error while creating socket: " << WSAGetLastError() << std::endl;
            WSACleanup();
        }
#endif
    }
}

UDPSender::~UDPSender() noexcept {
    if (!(m_socket < 0)) {
#ifdef WIN32
        ::shutdown(m_socket, SD_BOTH);
        ::closesocket(m_socket);
        WSACleanup();
#else
        ::shutdown(m_socket, SHUT_RDWR); // Disallow further read/write operations.
        ::close(m_socket);
#endif
    }
    m_socket = -1;
}

uint16_t UDPSender::getSendFromPort() const noexcept {
    return m_portToSentFrom;
}

std::pair<ssize_t, int32_t> UDPSender::send(std::string &&data) const noexcept {
    if (-1 == m_socket) {
        return {-1, EBADF};
    }

    if (data.empty()) {
        return {0, 0};
    }

    constexpr uint16_t MAX_LENGTH = static_cast<uint16_t>(UDPPacketSizeConstraints::MAX_SIZE_UDP_PACKET)
                                    - static_cast<uint16_t>(UDPPacketSizeConstraints::SIZE_IPv4_HEADER)
                                    - static_cast<uint16_t>(UDPPacketSizeConstraints::SIZE_UDP_HEADER);
    if (MAX_LENGTH < data.size()) {
        return {-1, E2BIG};
    }

    std::lock_guard<std::mutex> lck(m_socketMutex);
    ssize_t bytesSent = ::sendto(m_socket,
                                 data.c_str(),
                                 data.length(),
                                 0,
                                 reinterpret_cast<const struct sockaddr *>(&m_sendToAddress), // NOLINT
                                 sizeof(m_sendToAddress));

    return {bytesSent, (0 > bytesSent ? errno : 0)};
}
} // namespace cluon
