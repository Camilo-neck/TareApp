from docx import Document
import sys
import os
import comtypes.client
import re
import docx
import pkg_resources
pkg_resources.require("xlrd==1.2.0")
import xlrd
import xlsxwriter

from datetime import datetime as dt
import locale

class FormattedDocument:
    #Defining constructor for class
    def __init__(self, path, ExcDoc=None):
        self.path = path
        self.plainText = self.setPlainText()
        self.formatAmount = self.setFormatAmount()
        self.formatSet = self.setFormatSet()
        self.formatDictionary = {}
        self.docxDoc = docx.Document(self.path)
        self.ExcDoc = ExcDoc
        #Stablish region for the language used in date formating
        locale.setlocale(locale.LC_TIME, '')
        #Create actualDate object
        self.actualDate = dt.now()

    #Defining methods to get or modify class attributes
    def getPath(self):
        return self.path

    def setPath(self,stringPath):
        self.path = stringPath
    
    def getExcDoc(self):
        return self.ExcDoc
    
    def getDocxDoc(self):
        return self.docxDoc
    
    def setPlainText(self):
        #Creating docx document
        doc = docx.Document(self.path)
        #Saving each paragraph in the doxc document
        fullText = []
        for para in doc.paragraphs:
            fullText.append(para.text)
        #Returning data
        return '\n'.join(fullText)
    
    def getPlainText(self):
        return self.plainText
    
    def setFormatAmount(self):
        #Getting the plain text information from the document
        toStrDoc = self.getPlainText()
        #Searching all format patterns using regex
        allFormatsList = re.findall("(\[\w*\d*\])",toStrDoc)
        #Creating a list with all formats with no repetition
        FormatsNoRep = []
        for element in allFormatsList:
            if (element not in FormatsNoRep):
                FormatsNoRep.append(element)
        #Returning data
        return len(FormatsNoRep)
    
    def getFormatAmount(self):
        return self.formatAmount
    
    def setFormatSet(self):
        #Getting the plain text information from the document
        toStrDoc = self.getPlainText()
        #Searching all format patterns using regex
        allFormatsList = re.findall("(\[\w*\d*\])",toStrDoc)
        #Creating a list with all formats with no repetition
        FormatsNoRep = []
        for element in allFormatsList:
            if (element not in FormatsNoRep):
                FormatsNoRep.append(element)
        #Returning data
        return FormatsNoRep
    
    def getFormatSet(self):
        return self.formatSet
    
    def DictFromExc(self, pathToExc):
        # Creating Excel document objects
        loc = (pathToExc)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        rows = sheet.nrows
        #Creating the main dictionary using the Excel file information
        dictionary = {}
        rowsList = []
        for x in range(7,rows):
            rowsList.append(sheet.row_values(x))
        for row in rowsList:
            for x in range(len(row)):
                if isinstance(row[x], float):
                    row[x] = str(int(row[x]))
        for row in rowsList:
            #set dict keys and values (if date format is presented in value it will be changued via mapping)   
            dictionary['\\' +row[0][:-1] + '\\]'] = list(map(lambda v: self.actualDate.strftime(v),row[1:]))

        #Returning dict
        self.formatDictionary = dictionary
        
    
    def lgthNamePdfTemp(self,pathToExc):
        # Creating document
        loc = (pathToExc)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        rows = sheet.nrows
        #Creating a dictionary that will contain some information about the user's preferences
        #Creating an auxiliary list
        NameAndPdf = {}
        rowsList = []
        #Adding URL information
        NameAndPdf[sheet.row_values(0)[0]] = sheet.row_values(0)[1]
        #Adding 'NOMBRE ARCHIVO', 'CREAR PDF', 'NOMBRE PDF' with its values to the dictionary using the aux list
        for x in range(4,8):
            rowsList.append(sheet.row_values(x))
        for row in rowsList:
            NameAndPdf[row[0]] = list(map(lambda v: self.actualDate.strftime(v),row[1:]))
        
        #Returning data
        return len(rowsList[0]), NameAndPdf
        
    
    def getFormatDict(self):
        return self.formatDictionary
    
    def docx_replace_regex(self, doc_obj, regex , replace):
        #Checking all paragraphs
        for p in doc_obj.paragraphs:
            #Searching for the pattern using regex
            if regex.search(p.text):
                inline = p.runs
                # Loop added to work with runs (strings with same style)
                for i in range(len(inline)):
                    if regex.search(inline[i].text):
                        text = regex.sub(replace, inline[i].text)
                        inline[i].text = text
        #Searching for patterns in all the tables in the document
        for table in doc_obj.tables:
            for row in table.rows:
                for cell in row.cells:
                    self.docx_replace_regex(cell, regex , replace)
        
    
    def create_pdf(self,docPath,name):
        #This function creates and saves a PDF from a docx file
        wdFormatPDF = 17
        in_file = os.path.abspath(docPath)
        out_file = os.path.abspath(name)
        word = comtypes.client.CreateObject('Word.Application')
        doc = word.Documents.Open(in_file)
        doc.SaveAs(out_file, FileFormat=wdFormatPDF)
        doc.Close()
        word.Quit()
    
    def validateTemplate(self):
        mainDictionary = self.getFormatDict()
        formatList = self.getFormatSet().copy()
        for x in range(len(formatList)):
            newStr = "\\" + formatList[x][:-1] + "\\]"
            formatList[x] = newStr
        if set(mainDictionary) == set(formatList):
            return True
        else:
            return False


class User:
    #Defining constructor
    def __init__(self,document,profiles=None):
        self.document = document
        self.profiles = profiles
        self.status = 0
        self.log = ""

    def changeDocument(self,dirPath):
        #Initializing information
        pathToExc = self.document.getExcDoc()
        self.document.DictFromExc(pathToExc)
        dictionary = self.document.getFormatDict()
        try:
            if self.document.validateTemplate() and os.path.isdir(dirPath):
                #Replacement process
                (length,dictNamePdf) = self.document.lgthNamePdfTemp(pathToExc)
                for x in range(length-1):
                    self.document.docxDoc = docx.Document(self.document.path)
                    for word, replacement in dictionary.items():
                        doc = self.document.getDocxDoc()
                        word_re=re.compile(word)
                        self.document.docx_replace_regex(doc,word_re , replacement[x])
                    
                    #Saving and creating pdf if the user desires it in the Excel file contents
                    fullPath = dirPath + "/"+dictNamePdf["NOMBRE ARCHIVO"][x]+ ".docx"
                    doc.save(fullPath)
                    if dictNamePdf["CREAR PDF"][x] == "SI":
                        
                        pdfpath = dirPath + "/"+dictNamePdf["NOMBRE PDF"][x]+".pdf"
                        self.document.create_pdf(fullPath,pdfpath)
                self.log="Documentos generados correctamente"
            else:
                self.status = 1
                self.log="Hubo un problema al generar los documentos,\npor favor, revise la información de su perfil"
        except Exception as e:
            self.status = 1
            self.log = str(e)
