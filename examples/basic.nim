import minidocx

var doc: Document
let p1 = doc.appendParagraph("Hello, World!", pt2Twip(0.6), "Times New Roman")
echo doc.save("a.docx")

