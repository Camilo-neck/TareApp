# This Python file uses the following encoding: utf-8
import sys
import os
import datetime

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
import consultant
import pdfApp

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
    result = Signal(str)

    # Merge pdfs
    @Slot(str,str)
    def mergePdf(self, file_paths, output_name):

        if ".pdf" not in output_name:
            output_name += ".pdf"

        file_paths = [e.replace('file:///','') for e in file_paths.split(',')]
        pdfApp.merge_pdfs(file_paths,output_name)

    @Slot(str, result=int)
    def getPages(self, str):
        return pdfApp.getPages(str)

    # Send text
    @Slot(str)
    def startSearch(self, text):
        texto = consultant.main(text)
        self.result.emit(str(texto))

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
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Load QML File
    engine.load(os.path.join(os.path.dirname(__file__), "Interface/qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
