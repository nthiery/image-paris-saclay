/***************************************************************************
* Copyright (c) 2016, Johan Mabille, Loic Gouarin and Sylvain Corlay       *
*                                                                          *
* Distributed under the terms of the BSD 3-Clause License.                 *
*                                                                          *
* The full license is in the file LICENSE, distributed with this software. *
****************************************************************************/

#ifndef XCPP_MIME_HPP
#define XCPP_MIME_HPP

#include "cling/Interpreter/RuntimePrintValue.h"
#include "xeus/xjson.hpp"

// Patch for info-111: print type information alongside outputs
#include <cxxabi.h>
template<class C>
char * type(C c) {
    int status;
    char * demangled;
    return abi::__cxa_demangle(typeid(c).name(),0,0,&status);
}

namespace xcpp
{
    // Default implementation of mime_bundle_repr
    template <class T>
    xeus::xjson mime_bundle_repr(const T& value)
    {
        auto bundle = xeus::xjson::object();
        bundle["text/plain"] = cling::printValue(&value) + "\ntype: "+type(value);
        return bundle;
    }
}

#endif
