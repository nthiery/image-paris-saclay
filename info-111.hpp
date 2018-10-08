#ifndef INFO_111
#define INFO_111

/// - ASSERT macro
#define ASSERT(C) if ( !(C) ) { throw std::runtime_error("\x1b[48;5;224mTest failed: "#C); }

#endif
