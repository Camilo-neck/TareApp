# This Python file uses the following encoding: utf-8
import sys
import os
import datetime
from socket import *
import xlsxwriter
import xlrd
import platform
import subprocess

from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *

# Import Circular Progress
from circular_progress import CircularProgress
from circular_progress import Ui_SplashScreen


from Data import Wiki, Google, Url, MyText, PdfApp, User, FormattedDocument, FileOrganizer

import os

# import traceback
from time import sleep

# Verify Connection
def is_connected():
    s = socket(AF_INET, SOCK_STREAM)
    s.settimeout(2)
    try:
        s.connect(('socket.io',80))
        s.close()
        return True
    except gaierror:
        return False

counter = 0
#Splash Screen
class SplashScreen(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        self.ui = Ui_SplashScreen()
        self.ui.setupUi(self)

        # Remove Title bar
        self.setWindowFlags(Qt.FramelessWindowHint)
        self.setAttribute(Qt.WA_TranslucentBackground)

        # Import Circular Progress
        self.progress = CircularProgress()
        self.progress.width = 270
        self.progress.height = 270
        self.progress.progress_color = QColor(85, 233, 245, 96)
        self.progress.setFixedSize(self.progress.width, self.progress.height)
        self.progress.move(15, 15)
        self.progress.add_shadow(True)
        self.progress.font_size = 25
        self.progress.bg_color = QColor( 210, 239, 245, 160)
        self.progress.enable_bg = True
        self.progress.setParent(self.ui.centralwidget)
        self.progress.show()

        self.shadow = QGraphicsDropShadowEffect(self)
        self.shadow.setBlurRadius(15)
        self.shadow.setXOffset(0)
        self.shadow.setYOffset(0)
        self.shadow.setColor(QColor(0,0,0,120))
        self.setGraphicsEffect(self.shadow)

        # QTimer
        self.timer = QTimer()
        self.timer.timeout.connect(self.update)
        self.timer.start(20)

        self.show()

    def update(self):
        global counter

        # Set the value to progress bar
        self.progress.setValue(counter)

        # Close the splash screen and open main app
        if counter >= 100:
            # Stop timer
            self.timer.stop()
            #Close
            self.destroy()

            # Open main app
            engine = QQmlApplicationEngine()

            engine.rootContext().setContextProperty("backend", MainWindow())
            engine.load(os.path.join(os.path.dirname(__file__), "Interface/qml/main.qml"))
            engine.start()

            if not engine.rootObjects():
                sys.exit(-1)

        # Increase Counter
        counter += 1

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        # Qtimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)
        self.currentOs = platform.system()

    # Signal Set name
    setName = Signal(str)

    # Signal Set Date
    printTime = Signal(str)

    # Signal Visible
    isVisible = Signal(bool)

    # Open File to Text Edit
    readText = Signal(str)

    # text String
    textField = ""

    # Result
    response = Signal(str)
    # Keys
    keys = Signal(str)

    @Slot()
    def longF(self):
        for i in range(5):
            print(i)
            sleep(1)

    @Slot()
    def testF(self):
        print('clicked')
    def getTemplateDict(self, pathToExc):
        # Creating document
        loc = (pathToExc)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        rows = sheet.nrows
        tDict = {}
        #Add template
        tDict[sheet.row_values(0)[0]] = sheet.row_values(0)[1]
        
        return tDict

    #Open Excel profile
    @Slot(str)
    def openProfile(self,profilePath):
        #Opening the profile in 'profilePath'
        if self.currentOs == 'Windows':
            os.startfile(profilePath)
        else:
            subprocess.call(["xdg-open", '/'+profilePath])


    #Generate formatted documents
    @Slot(str,str)
    def generateDocuments(self,profilePath, dirPath):
        if self.currentOs != 'Windows':
            profilePath = '/'+profilePath
            dirPath = '/' + dirPath
        try:
            #Creating main dictionary
            docDict = self.getTemplateDict(profilePath)
            #Getting URL information to find the desired docx template
            dPath = docDict["URL"]
            #Creating FormattedDocument object
            Documento = FormattedDocument(dPath,profilePath)
            #Creating User object
            Usuario = User(Documento)
            #Generating formatted document with the user's indications according to the profile
            Usuario.changeDocument(dirPath)
        except Exception as e:
            print(e)
    
    #Create profile
    @Slot(str,str,str,str)
    def createProfile(self,templatePath,templateName,dirPath, profileName):
        if self.currentOs != 'Windows':
            templatePath = '/' + templatePath
            dirPath = '/' + dirPath
        #Create document
        document = FormattedDocument(templatePath)
        formatList = list(document.getFormatSet())
        #Creating and setting up Excel file
        newExc = dirPath+profileName+".xlsx"
        workbook = xlsxwriter.Workbook(newExc)
        worksheet = workbook.add_worksheet()
        worksheet.set_column(0, 0, 25)
        worksheet.set_column(0, 1, 25)
        bold = workbook.add_format({'bold': True})
        cell_format = workbook.add_format()
        cell_format.set_align('fill')
        #Writting main information to the Excel document with indications to the user
        worksheet.write('A1', 'URL',bold)
        worksheet.write('B1', templatePath,cell_format)
        worksheet.write('A2', "PLANTILLA",bold)
        worksheet.write('B2', templateName)
        worksheet.write('B3', "VALUE_1",bold)
        worksheet.write('A3', 'KEY',bold)
        worksheet.write('A4', 'NOMBRE ARCHIVO')
        worksheet.write('B4', 'Ingrese un nombre')
        worksheet.write('A5', 'CREAR PDF')
        worksheet.write('B5', 'SI/NO')
        worksheet.write('A6', 'NOMBRE PDF')
        worksheet.write('B6', 'Ingrese un nombre')
        index = 0
        for x in range(7,len(formatList)+7):
            cell = 'A'+str(x)
            sideCell = 'B' + str(x)
            worksheet.write(cell, formatList[index])
            worksheet.write(sideCell, "Ingrese un valor")
            index += 1
        #Closing...
        workbook.close()

    # Ordenar Carpetas
    @Slot(int,str,list,list,list,bool)
    def organizeFiles(self, sortMethod,path,names,extTags,ignored_ext,moveToDefault):
        if self.currentOs != 'Windows':
            path = '/' + path
        folders = []
        for name,e in zip(names,extTags):
            if sortMethod == 0:
                folder = {
                    'name':name,
                    'extensions': [f'.{ext}' for ext in e.split(' ')]
                }
            else:
                folder = {
                    'name':name,
                    'keywords': [keyword for keyword in e.split(' ')]
                }
            folders.append(folder)

        organizer = FileOrganizer(sortMethod,path,folders,ignored_ext,moveToDefault)
        organizer.organizeAllFiles()


    # Obtener lista de archivos de una carpeta
    @Slot(str, result = list)
    def getFilesFromFolder(self, folderUrl):
        if self.currentOs != 'windows':
            folderUrl = '/' + folderUrl

        if not os.path.isdir(folderUrl): return ["NULL"]
        #print(">>>>>>>>>>>>",folderUrl)
        fileUrls = []
        #if os.path.isfile(f)
        files = [f for f in os.listdir(folderUrl)]
        for file in files:
            fileUrl = folderUrl+'//'+file
            if not os.path.isdir(fileUrl):
                fileUrls.append(fileUrl)
        #print("++++++++++++++++",fileUrls)
        return fileUrls

    # Etiquetar archivos
    @Slot(str,str)
    def tagFiles(self, urls,etiqueta):

        if self.currentOs != 'windows': urls = ['/'+e.replace('file:///','') for e in urls.split(',')]
        else: urls = [e.replace('file:///','') for e in urls.split(',')]

        for path in urls:
            fileName, ext = os.path.splitext(path)
            print("FILE PATH >>>>>>>>",path)
            try:
                os.rename(path , fileName+" "+etiqueta+ext)
            except:
                print("ERROR")

    # Merge pdfs
    @Slot(str,str)
    def mergePdf(self, file_paths, output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        if self.currentOs != 'windows': 
            file_paths = ['/'+e.replace('file:///','') for e in file_paths.split(',')]
        else: file_paths = [e.replace('file:///','') for e in file_paths.split(',')]

        p = PdfApp(paths = file_paths,outPath = '/'+output_path)
        p.merge_pdfs()

    # Build PDF
    @Slot(str,list,str)
    def buildPdf(self,path, pages_list ,output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        path = '/' + output_path.replace('file:///','')

        p = PdfApp(paths = path, outPath = '/'+output_path, pagesList = pages_list)
        p.buildPdf()

    # get Pdf Num pages
    @Slot(str, result=int)
    def getPages(self, str):
        p = PdfApp(str)
        return p.getPages()

    # Send text
    @Slot(str, bool, str, result=str)
    def startSearch(self, text, openai, engine):
        if is_connected():
            if engine == 'W':
                consultant = Wiki()
            if engine == 'G':
                consultant = Google()
            if engine == 'U':
                consultant = Url()
            if engine == 'T':
                consultant = MyText()
            
            consultant.set_query(text)
            consultant.set_openai(openai)
            texto, claves = consultant.consult()
        else:
            texto = "Por favor revise su conexión a internet."
            claves = "Por favor revise su conexión a internet."
        
        self.response.emit(str(texto))
        self.keys.emit(str(claves))


        return str(texto)

    # Read Text
    @Slot(str)
    def getTextField(self, text):
        self.textField = text

    # Save File
    @Slot(str)
    def writeFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), "w")
        file.write(self.textField)
        file.close()

    # Open File
    @Slot(str)
    def openFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), encoding="UTF-8")
        text = file.read()
        file.close()
        self.readText.emit(str(text))

    # Show / Hide Rectangle
    @Slot(bool)
    def showHideRectangle(self, isChecked):
        self.isVisible.emit(isChecked)

    # Set timer Function
    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        self.printTime.emit(formatDate)

    # Function Set Name to Label
    @Slot(str)
    def welcomeText(self, name):
        if name == '':
            self.setName.emit("Welcome")
        else:
            self.setName.emit(f"Welcome, {name}")



if __name__ == "__main__":
    app = QApplication(sys.argv)

    window = SplashScreen()

    sys.exit(app.exec_())
