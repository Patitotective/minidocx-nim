when not defined(cpp):
  {.error: "C++ backend required to use minidocx".}

import std/os
import cppstl

const
  currentDir = currentSourcePath.parentDir()
  minidocxHeaderPath {.strdefine.} = currentDir / "../minidocx/src/minidocx.hpp"
  minidocxSourcePath {.strdefine.} = currentDir / "../minidocx/src/minidocx.cpp"
  zipDirectory {.strdefine.} = currentDir / "../minidocx/3rdparty/zip-0.2.1"
  zipSourcePath {.strdefine.} = currentDir / "../minidocx/3rdparty/zip-0.2.1/zip.c"
  pugixmlDirectory {.strdefine.} = currentDir / "../minidocx/3rdparty/pugixml-1.13"
  pugixmlSourcePath {.strdefine.} = currentDir / "../minidocx/3rdparty/pugixml-1.13/pugixml.cpp"

{.passc: "-I" & zipDirectory & " -I" & pugixmlDirectory.}
{.compile: zipSourcePath.}
{.compile: pugixmlSourcePath.}
{.compile: minidocxSourcePath.}

converter toStr*(s: string): CppString =
  initCppString(s)

{.push header: minidocxHeaderPath.}

type
  Document* {.importcpp: "docx::Document".} = object
  Paragraph* {.importcpp: "docx::Paragraph".} = object

proc appendParagraph*(doc: var Document): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString, fontSize: float): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString, fontSize: float, fontAscii: CppString, fontEastAsia = initCppString()): Paragraph {.importcpp: "AppendParagraph".}

proc save*(doc: var Document, path: CppString): bool {.importcpp: "Save".}

