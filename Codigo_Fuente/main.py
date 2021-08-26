# This Python file uses the following encoding: utf-8
from shutil import ExecError
from core import *

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

#verify is a file or a folder is hidden
def is_hidden(p):
    attribute = GetFileAttributes(p)
    return attribute & (FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM)

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
            raise ExecError

        # Increase Counter
        counter += 1

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.file_tag = 'file:///'
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

    @Slot(str, result=bool)
    def confirm(self, url) -> bool:
        result = QMessageBox(QMessageBox.Warning, "Advertencia!", f'¿Está seguro de ordenar {url} ?\n Esta acción es irreversible.')
        yes = QMessageBox.addButton(result, "Si", QMessageBox.AcceptRole)
        QMessageBox.addButton(result, "Cancelar", QMessageBox.RejectRole)
        result.exec_()
        return result.clickedButton() == yes

    @Slot()
    def longF(self):
        for i in range(5):
            print(i)
            sleep(1)

    def getTemplateDict(self, path_to_exc):
        # Creating document
        loc = (path_to_exc)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        t_dict = {}
        #Add template
        t_dict[sheet.row_values(0)[0]] = sheet.row_values(0)[1]
        t_dict[sheet.row_values(1)[0]] = sheet.row_values(1)[1]
        
        return t_dict

    #Open Excel profile
    @Slot(str)
    def openProfile(self,profile_path):
        #Opening the profile in 'profile_path'
        if self.currentOs == 'Windows':
            os.startfile(profile_path)
        else:
            subprocess.call(["xdg-open", '/'+profile_path])


    #Generate formatted documents
    @Slot(str, result = list)
    def generateDocuments(self,profile_path):
        try:
            #Creating main dictionary
            doc_dict = self.getTemplateDict(profile_path)
            #Getting URL information to find the desired docx template and defined dir to save the documents
            d_path = doc_dict["URL Plantilla"]
            dir_path = doc_dict["URL Documentos"]
            #Creating FormattedDocument object
            documento = FormattedDocument(d_path,profile_path)
            #Creating User object
            usuario = User(documento)
            #Generating formatted document with the user's indications according to the profile
            usuario.change_document(dir_path)
            return [usuario.status, usuario.log]
        except Exception as e:
            print(e)
    
    #Create profile
    @Slot(str,str,str,str)
    def createProfile(self,template_path,template_name,profile_dir,docs_dir):
        #Create document
        document = FormattedDocument(template_path)
        format_list = list(document.get_format_set())
        #Creating and setting up Excel file
        #new_exc = profile_dir+profile_name+".xlsx"
        new_exc = profile_dir
        workbook = xlsxwriter.Workbook(new_exc)
        worksheet = workbook.add_worksheet()
        worksheet.set_column(0, 0, 28)
        worksheet.set_column(0, 1, 28)
        bold = workbook.add_format({'bold': True})
        cell_format = workbook.add_format()
        cell_format.set_align('fill')
        #Writting main information to the Excel document with indications to the user
        worksheet.write('A1', 'URL Plantilla',bold)
        worksheet.write('A2', 'URL Documentos',bold)
        worksheet.write('B1', template_path,cell_format)
        worksheet.write('B2', docs_dir,cell_format)
        worksheet.write('A3', "PLANTILLA",bold)
        worksheet.write('B3', template_name)
        worksheet.write('A4', 'LLAVE',bold)
        worksheet.write('B4', "DOCUMENTO 1",bold)
        worksheet.write('A5', 'NOMBRE ARCHIVO')
        worksheet.write('B5', 'Ingrese un nombre')
        worksheet.write('A6', 'CREAR PDF')
        worksheet.write('B6', 'SI/NO')
        worksheet.write('A7', 'NOMBRE PDF')
        worksheet.write('B7', 'Ingrese un nombre')
        index = 0
        for x in range(8,len(format_list)+8):
            cell = 'A'+str(x)
            side_cell = 'B' + str(x)
            worksheet.write(cell, format_list[index])
            worksheet.write(side_cell, "Ingrese un valor")
            index += 1
        #Closing...
        workbook.close()

    # Guardar info carpetas
    @Slot(str,str,list,list,int,bool)
    def saveFoldersInfo(self,saving_path,path,names,ext_tags,method,move_to_default):
        s = SaveFile()
        s.setAttributes(path,names,ext_tags,method,move_to_default)
        s.save(saving_path)

    # Cargar info carpetas
    @Slot(str,result=list)
    def loadFoldersInfo(self, path):
        l = SaveFile()
        l.load(path)
        if l.ok:
            folder_names = []
            ext_tags = []

            if l.organize_method == 0: value = 'extensions'
            else: value = 'keywords'

            for folder in l.folders:
                folder_names.append(folder['name'])
                ext_tags.append(folder[value])

            return [l.folder_path,l.organize_method,l.move_to_default,folder_names,ext_tags]
        return [l.log]

    # Ordenar Carpetas
    @Slot(int,str,list,list,list,bool,result=str)
    def organizeFiles(self, sort_method,path,names,ext_tags,ignored_ext,move_to_default):
        if self.currentOs != 'Windows':
            path = '/' + path

        organizer = FileOrganizer(path,names,ext_tags,sort_method,ignored_ext,move_to_default)
        organizer.organize_all_files()
        return organizer.log

    # Obtener lista de archivos de una carpeta
    @Slot(str, result = list)
    def getFilesFromFolder(self, folder_url):
        if not os.path.isdir(folder_url): return ["NULL"]
        full_list = map(lambda f: os.path.join(folder_url,f) ,os.listdir(folder_url))
        return list(filter(lambda f: (os.path.isfile(f) and not is_hidden(f)), full_list))

    # Etiquetar archivos, borrar etiquetas
    @Slot(str,str,int)
    def tagFiles(self, urls,etiqueta,action):

        if self.currentOs != 'Windows': urls = ['/'+e.replace(self.file_tag,'') for e in urls.split(',')]
        else: urls = [e.replace(self.file_tag,'') for e in urls.split(',')]

        for path in urls:
            file_name, ext = os.path.splitext(path)
            print("FILE PATH >>>>>>>>",path)
            try:
                if action==0: os.rename(path , file_name+etiqueta+ext)
                elif action==1: os.rename(path , file_name.replace(etiqueta,'')+ext)
            except:
                print("ERROR")

    # Merge pdfs
    @Slot(str,str)
    def mergePdf(self, file_paths, output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        if self.currentOs != 'Windows': 
            file_paths = ['/'+e.replace(self.file_tag,'') for e in file_paths.split(',')]
            output_path = '/'+output_path
        else: file_paths = [e.replace(self.file_tag,'') for e in file_paths.split(',')]

        p = PdfApp(paths = file_paths,outPath = output_path)
        p.merge_pdfs()

    # Build PDF
    @Slot(str,list,str)
    def buildPdf(self,path, pages_list ,output_path):

        if ".pdf" not in output_path: output_path += ".pdf"
        path = output_path.replace(self.file_tag,'')
        if self.currentOs != 'Windows':
            path = '/' + path
            output_path = '/' + output_path

        p = PdfApp(paths = path, outPath = output_path, pagesList = pages_list)
        p.build_pdf()

    # get Pdf Num pages
    @Slot(str, result=int)
    def getPages(self, str1):
        if str1 != '':
            p = PdfApp(str1)
            return p.get_pages()
        return 0
        
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

    # Set timer Function
    def setTime(self):
        now = datetime.datetime.now()
        format_date = now.strftime("%H:%M:%S %p - %d/%m/%Y")
        self.printTime.emit(format_date)

if __name__ == "__main__":
    app = QApplication(sys.argv)

    window = SplashScreen()
    app.setWindowIcon(QIcon('Interface/images/icon.ico'))

    sys.exit(app.exec_())
