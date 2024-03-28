# Package

version       = "0.1.0"
author        = "Patitotective"
description   = "A wrapper for minidocx"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["examples"]
skipExt       = @["txt", "md", "sh"]

# Dependencies

requires "nim >= 2.0.0"
requires "cppstl >= 0.6.2"

