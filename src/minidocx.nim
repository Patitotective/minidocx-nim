when not defined(cpp):
  {.error: "C++ backend required to use minidocx".}

import std/os
import cppstl

const
  currentDir = currentSourcePath.parentDir()
  minidocxHeaderPath {.strdefine.} = currentDir / "minidocx/src/minidocx.hpp"
  minidocxSourcePath {.strdefine.} = currentDir / "minidocx/src/minidocx.cpp"
  zipDirectory {.strdefine.} = currentDir / "minidocx/3rdparty/zip-0.2.1"
  zipSourcePath {.strdefine.} = currentDir / "minidocx/3rdparty/zip-0.2.1/zip.c"
  pugixmlDirectory {.strdefine.} = currentDir / "minidocx/3rdparty/pugixml-1.13"
  pugixmlSourcePath {.strdefine.} = currentDir / "minidocx/3rdparty/pugixml-1.13/pugixml.cpp"

{.passc: "-I" & zipDirectory & " -I" & pugixmlDirectory.}
{.compile: zipSourcePath.}
{.compile: pugixmlSourcePath.}
{.compile: minidocxSourcePath.}

converter toStr*(s: string): CppString =
  initCppString(s)

{.push header: minidocxHeaderPath.}

type
  Bookmark* {.importcpp: "docx::Bookmark".} = object
  Document* {.importcpp: "docx::Document".} = object
  Paragraph* {.importcpp: "docx::Paragraph".} = object
  Section* {.importcpp: "docx::Section".} = object
  Run* {.importcpp: "docx::Run".} = object
  Table* {.importcpp: "docx::Table".} = object
  TableCell* {.importcpp: "docx::TableCell".} = object
  TextFrame* {.importcpp: "docx::TextFrame".} = object

  BorderStyle* {.size: sizeof(cint), importcpp: "docx::Box::BorderStyle".} = enum
    Single, Dotted, Dashed, DotDash, Double, Wave, None

  Cell* {.importcpp: "docx::Cell", header: "minidocx.hpp", bycopy.} = object
    row* {.importc: "row".}: cint##  position
    col* {.importc: "col".}: cint ##  position
    rows* {.importc: "rows".}: cint ##  size
    cols* {.importc: "cols".}: cint ##  size

  Row* = CppVector[Cell]
  Grid* = CppVector[Row]

proc pt2Twip*(pt: float): int {.importcpp: "docx::Pt2Twip(#)".}
proc twip2Pt*(twip: int): float {.importcpp: "docx::Twip2Pt(#)".}

proc inch2pt*(inch: float): float {.importcpp: "docx(#)::Inch2Pt".}
proc pt2inch*(pt: float): float {.importcpp: "docx::Pt2Inch(#)".}

proc mm2inch*(mm: int): float {.importcpp: "docx::MM2Inch(#)".}
proc inch2Mm*(inch: float): int {.importcpp: "docx::Inch2MM(#)".}

proc cm2inch*(cm: float): float {.importcpp: "docx::CM2Inch(#)".}
proc inch2cm*(inch: float): float {.importcpp: "docx::Inch2CM(#)".}

proc inch2twip*(inch: float): int {.importcpp: "docx::Inch2Twip(#)".}
proc twip2inch*(twip: int): float {.importcpp: "docx::Twip2Inch(#)".}

proc mm2twip*(mm: int): int {.importcpp: "docx::MM2Twip(#)".}
proc twip2mm*(twip: int): int {.importcpp: "docx::Twip2MM(#)".}

proc cm2twip*(cm: float): int {.importcpp: "docx::CM2Twip(#)".}
proc twip2cm*(twip: int): float {.importcpp: "docx::Twip2CM(#)".}

# proc constructTableCell*(): TableCell {.constructor, importcpp: "docx::TableCell(@)".}
converter toBool*(this: var TableCell): bool {.importcpp: "TableCell::operator bool",
    header: "minidocx.hpp".}
proc empty*(this: TableCell): bool {.noSideEffect, importcpp: "empty",
                                 header: "minidocx.hpp".}
proc SetWidth*(this: var TableCell; w: cint; units: cstring = "dxa") {.
    importcpp: "SetWidth", header: "minidocx.hpp".}

proc appendParagraph*(doc: var Document): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString, fontSize: float): Paragraph {.importcpp: "AppendParagraph".}
proc appendParagraph*(doc: var Document, text: CppString, fontSize: float, fontAscii: CppString, fontEastAsia = initCppString()): Paragraph {.importcpp: "AppendParagraph".}

proc save*(doc: var Document, path: CppString): bool {.importcpp: "Save".}

