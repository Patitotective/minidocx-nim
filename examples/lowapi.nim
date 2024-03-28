import minidocx/lowapi

var doc: Document
let p1 = doc.appendParagraph("Hello, World!", 12, "Times New Roman")
assert doc.save("lowapi.docx")

