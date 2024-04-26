import aspose.words as aw


aw.License().set_license('Aspose.WordsforPythonvia.NET.lic')

doc = aw.Document('example.docx')
doc.save('example.txt')