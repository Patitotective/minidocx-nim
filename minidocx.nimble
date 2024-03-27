# Package

version       = "0.1.0"
author        = "Patitotective"
description   = "A wrapper for minidocx"
license       = "MIT"
srcDir        = "src"
backend       = "cpp"
installDirs   = @[".", "minidocx/src", "minidocx/3rdparty"]
# installFiles   = @["minidocx/src/minidocx.hpp", "minidocx/src/minidocx.cpp"]

# Dependencies

requires "nim >= 2.0.0"
requires "cppstl >= 0.6.2"

