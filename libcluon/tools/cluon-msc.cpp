/*
 * Copyright (C) 2017-2018  Christian Berger
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

#include "cluon/MessageParser.hpp"
#include "cluon/MetaMessage.hpp"
#include "cluon/MetaMessageToCPPTransformator.hpp"
#include "cluon/MetaMessageToProtoTransformator.hpp"

#include "argh/argh.h"

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

int main(int argc, char **argv) {
    const std::string PROGRAM{argv[0]}; // NOLINT
    argh::parser commandline(argc, argv);

    std::string inputFilename = commandline.pos_args().back();
    if (std::string::npos != inputFilename.find(PROGRAM)) {
        std::cerr << PROGRAM
                  << " transforms a given message specification file in .odvd format into C++." << std::endl;
        std::cerr << "Usage:   " << PROGRAM << " [--cpp-headers] [--cpp-sources] [--cpp-add-include-file=<string>] [--proto] [--out=<file>] <odvd file>" << std::endl;
        std::cerr << "         " << PROGRAM << " --cpp-headers <odvd file>" << std::endl;
        std::cerr << "         " << PROGRAM << " --cpp-sources <odvd file>" << std::endl;
        std::cerr << "         " << PROGRAM << " --cpp-headers --out=<target file> <odvd file>" << std::endl;
        std::cerr << "         " << PROGRAM << " --cpp-sources --cpp-add-include-file=dir/file.hpp --out=<target file> <odvd file>" << std::endl;
        std::cerr << "         " << PROGRAM << " --proto <odvd file>" << std::endl;
        std::cerr << std::endl;
        std::cerr << "Example: " << PROGRAM << " --cpp-headers --out=/tmp/myOutput.hpp myFile.odvd" << std::endl;
        return 1;
    }

    std::string outputFilename;
    commandline({"--out"}) >> outputFilename;

    std::string CPPincludeFile;
    commandline({"--cpp-add-include-file"}) >> CPPincludeFile;

    const bool generateCPPHeaders = commandline[{"--cpp-headers"}];
    const bool generateCPPSources = commandline[{"--cpp-sources"}];
    const bool generateProto = commandline[{"--proto"}];

    int retVal = 1;
    std::ifstream inputFile(inputFilename, std::ios::in);
    if (inputFile.good()) {
        bool addHeaderForFirstProtoFile = true;
        std::string input(static_cast<std::stringstream const&>(std::stringstream() << inputFile.rdbuf()).str()); // NOLINT

        cluon::MessageParser mp;
        auto result = mp.parse(input);
        retVal = result.second;

        // Delete the content of a potentially existing file.
        if (!outputFilename.empty()) {
            std::ofstream outputFile(outputFilename, std::ios::out | std::ios::trunc);
            outputFile.close();
        }
        for (auto e : result.first) {
            std::string content;
            if (generateCPPHeaders || generateCPPSources) {
                cluon::MetaMessageToCPPTransformator transformation;
                e.accept([&trans = transformation](const cluon::MetaMessage &_mm){ trans.visit(_mm); });
                std::stringstream sstr;
                if (!CPPincludeFile.empty()) {
                    sstr << "#include <" << CPPincludeFile << ">" << std::endl;
                }
                if (generateCPPHeaders) {
                    sstr << transformation.contentHeader();
                }
                if (generateCPPSources) {
                    sstr << transformation.contentSource();
                }
                content = sstr.str();
            }
            if (generateProto) {
                cluon::MetaMessageToProtoTransformator transformation;
                e.accept([&trans = transformation](const cluon::MetaMessage &_mm){ trans.visit(_mm); });
                content = transformation.content(addHeaderForFirstProtoFile);
                addHeaderForFirstProtoFile = false;
            }

            if (!outputFilename.empty()) {
                std::ofstream outputFile(outputFilename, std::ios::out | std::ios::app);
                outputFile << content << std::endl;
                outputFile.close();
            }
            else {
                std::cout << content << std::endl;
            }
        }
    }
    else {
        std::cerr << "[" << PROGRAM << "] Could not find '" << inputFilename << "'." << std::endl;
    }

    return retVal;
}
