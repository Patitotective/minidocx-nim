import minidocx

var doc: Document
let p1 = doc.appendParagraph("Hello, World!", twip2Pt(200), "Times New Roman")
assert doc.save("basic.docx")

