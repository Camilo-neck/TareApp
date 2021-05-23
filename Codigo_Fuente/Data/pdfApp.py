from struct import error
from PyPDF2 import PdfFileReader, PdfFileWriter

class PdfApp():
    def __init__(self, paths = [] ,outPath = "", pagesList = []):       
        self.__pdfWriter = PdfFileWriter()
        self.__paths = paths
        self.__outPath = outPath
        self.__pagesList = pagesList

    def getPages(self):
        return PdfFileReader(self.__paths).getNumPages()

    def merge_pdfs(self):
        try:
            for path in self.__paths:
                self.__pdfReader = PdfFileReader(path, strict=False)
                for page in range(self.__pdfReader.getNumPages()):
                    self.__pdfWriter.addPage(self.__pdfReader.getPage(page))

            with open(self.__outPath, 'wb') as out:
                self.__pdfWriter.write(out)
        except error as e:
            print('error' + e)

    def buildPdf(self):
        self.__pdfReader = PdfFileReader(self.__paths)

        for i in range(len(self.__pagesList)):
            self.__pdfWriter.addPage(self.__pdfReader.getPage(int(self.__pagesList[i])))

        with open(self.__outPath, 'wb') as out:
            self.__pdfWriter.write(out)