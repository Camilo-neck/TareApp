from struct import error
from PyPDF2 import PdfFileReader, PdfFileWriter

class PdfApp():
    def __init__(self, paths = None ,out_path = "", pages_list = None):       
        self.__pdf_writer = PdfFileWriter()
        self.__paths = paths
        self.__out_path = out_path
        self.__pages_list = pages_list

    def get_pages(self):
        return PdfFileReader(self.__paths).getNumPages()

    def merge_pdfs(self):
        try:
            for path in self.__paths:
                self.__pdf_reader = PdfFileReader(path, strict=False)
                for page in range(self.__pdf_reader.getNumPages()):
                    self.__pdf_writer.addPage(self.__pdf_reader.getPage(page))

            with open(self.__out_path, 'wb') as out:
                self.__pdf_writer.write(out)
        except error as e:
            print('error' + e)

    def build_pdf(self):
        self.__pdf_reader = PdfFileReader(self.__paths)

        for i in range(len(self.__pages_list)):
            self.__pdf_writer.addPage(self.__pdf_reader.getPage(int(self.__pages_list[i])))

        with open(self.__out_path, 'wb') as out:
            self.__pdf_writer.write(out)