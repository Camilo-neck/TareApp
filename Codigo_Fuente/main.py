# This Python file uses the following encoding: utf-8
import sys
import os
import datetime

from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *

# Import Circular Progress
from circular_progress import CircularProgress
from circular_progress import Ui_SplashScreen


from Data import Wiki, Google, Url, MyText
import pdfApp

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



        # Increaase Counter
        counter += 1

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        # Qtimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

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

    # Merge pdfs
    @Slot(str,str)
    def mergePdf(self, file_paths, output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        file_paths = [e.replace('file:///','') for e in file_paths.split(',')]

        p = PdfApp(paths = file_paths,outPath = output_path)
        p.merge_pdfs()

    # Build PDF
    @Slot(str,list,str)
    def buildPdf(self,path, pages_list ,output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        path = path.replace('file:///','')

        p = PdfApp(paths = path, outPath = output_path, pagesList = pages_list)
        p.buildPdf()

    # get Pdf Num pages
    @Slot(str, result=int)
    def getPages(self, str):
        p = PdfApp(str)
        return p.getPages()

    # Send text
    @Slot(str, bool, str)
    def startSearch(self, text, openai, engine):
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
        texto = consultant.consult()
        self.response.emit(str(texto))

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
