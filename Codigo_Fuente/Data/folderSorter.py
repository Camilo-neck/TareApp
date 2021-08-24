import os
import shutil
import errno

import pkg_resources
pkg_resources.require("xlrd==1.2.0")
import xlrd
import xlsxwriter

def createFoldersList(folderNames,extTags,organizeMethod):
    folders = []
    for name,e in zip(folderNames,extTags):         
        folder = {}
        folder['name'] = name 
        if organizeMethod == 0: folder['extensions'] = e
        else: folder['keywords'] = e
        folders.append(folder)

    return folders

class FileOrganizer():
    def __init__(self,path,folderNames,extTags,organizeMethod,ignored_ext,moveToDefault):
        self.defaultFolder = {'name' : 'Otros'}
        self.path = path
        self.organizeMethod = organizeMethod
        self.folders = createFoldersList(folderNames,extTags,organizeMethod)
        for folder in self.folders:
            if self.organizeMethod==0: folder['extensions'] = [f'.{ext}' for ext in folder['extensions'].split(' ')]
            else: folder['keywords'] = [keyword for keyword in folder['keywords'].split(' ')]

        self.ignored_ext = ignored_ext
        self.moveToDefault = moveToDefault
        self.log = ''

    def createFolders(self):
        #try to create the indicate folders
        foldersM = self.folders[:]
        if self.moveToDefault == True: foldersM.append(self.defaultFolder)

        for folder in foldersM:
            name = folder['name']
            try:
                os.mkdir(os.path.join(self.path, name))
                print("Se ha creado la carpeta",name,"satisfacctoriamente")
            except OSError as e:
                if e.errno == errno.EEXIST: #if the folder already exist it will continue with the next folder
                    print("La carpeta",name,"ya existe")
                else: raise #if there is another error it will raise it (for example invalid name)
                
    def organizeFile(self,file):

        file_name , ext = os.path.splitext(file)
        file = '\\'+file
        if ext in self.ignored_ext: #the ignored extensions won´t be moved to any folder
            self.log += "\nEl archivo " + file[1:] + " No se movio ya que este se encuentra en la lista de ignorados"
            return None

        for folder in self.folders:
            #depending on the method the condition to move the file will be different
            if self.organizeMethod == 0: condition = ext in folder['extensions']
            elif self.organizeMethod == 1:
                condition = False
                for keyword in folder['keywords']:
                    if keyword in file:
                        condition = True
                        break

            if condition:
                final_path = self.path + '/'+folder['name']
                try: shutil.move(self.path + file, final_path)
                except shutil.Error as e: self.log += "\nNo se pudo mover el archivo "+file[1:] #str(e) //// if there was an error when moving the file it will continue with the next file
                return None

        if self.moveToDefault == True: #move the file to default folder if it wasn´t moved to any folder and if moveDefault == True
            final_path = self.path + '/'+self.defaultFolder['name']
            shutil.move(self.path + file, final_path)

    def organizeAllFiles(self):
        #try to sort all files, if one folder name is invalid it will stop the function via return None
        try: self.createFolders()
        except OSError as e:
            if e.errno == errno.EINVAL:
                self.log = "Una de las carpetas posee un nombre invalido"
                return None
            else: raise #on another error it will raise the error and closes the aplication (unexpected)
        else: 
            for file in os.listdir(self.path): 
                if not os.path.isdir(self.path+'//'+file): #if the file isn´t a folder it will try to sort it into a folder
                    print(">>>>>>>>>>FILE:",file)
                    self.organizeFile(file)
                else: print(">>>>>>>>>>FOLDER:",file) #if the file is a folder it will be ignored

class SaveFile():
    def __init__(self):
        self.folderPath = ''
        self.organizeMethod = -1
        self.moveToDefault = None
        self.folders = []
        self.log = ''
        self.ok = False
    
    def setAttributes(self, folderPath,folderNames,extTags,organizeMethod,moveToDefault):
        self.folderPath = folderPath
        self.organizeMethod = organizeMethod
        self.moveToDefault = moveToDefault
        self.folders = createFoldersList(folderNames,extTags,organizeMethod)
    
    def load(self, loadPath):
        if not os.path.isfile(loadPath):
            self.ok = False
            self.log = 'El archivo no existe en la ruta especificada'
            return None

        # Creating Excel document objects
        loc = (loadPath)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        rowsCount = sheet.nrows
        #get the Excel file information
        rowsList = []
        for x in range(rowsCount): rowsList.append(sheet.row_values(x))

        folderPath = rowsList[0][1]
        isDefaultFile = folderPath == "_DEFAULT_FILE"
        if not os.path.isdir(folderPath) and not isDefaultFile:
            self.ok = False
            self.log = 'La ruta de la carpeta a ordenar no existe'
            return None


        strMethod = rowsList[1][1]
        organizeMethod = (lambda strMethod : 0 if strMethod =='POR EXTENSION' else (1 if strMethod =='POR ETIQUETA' else -1))(strMethod)
        if organizeMethod == -1:
            self.ok = False
            self.log = 'Metodo invalido'
            return None

        strMoveToDefault = rowsList[2][1]
        moveToDefault = (lambda strMoveToDefault: strMoveToDefault=='SI')(strMoveToDefault)
        
        folderNames = []
        extTags = []
        for row in rowsList[3:]:
            folderNames.append(row[0])
            extTags.append(row[1])

        self.setAttributes(folderPath, folderNames, extTags, organizeMethod, moveToDefault)

        self.ok = True

    def save(self, savePath):#savePath must be non existing xlsx file
        #Creating and setting up Excel file
        if os.path.isfile(savePath):
            self.ok = False
            self.log = "El archivo de excel ya existe"
            return None
        newExc = savePath
        #print('RUTA EXCEL:',newExc)
        workbook = xlsxwriter.Workbook(newExc)
        worksheet = workbook.add_worksheet()
        bold = workbook.add_format({'bold': True})
        cell_format = workbook.add_format()
        cell_format.set_align('fill')
        #Writting main information to the Excel document with indications
        cellNames = ["RUTA CARPETA","METODO","MOVER A OTROS   "]

        if self.organizeMethod==0 : method = 'POR EXTENSION'
        else: method = 'POR ETIQUETA'

        if self.moveToDefault: toDefault = 'SI'
        else: toDefault = 'NO'

        cellValues = [self.folderPath,method,toDefault]

        if self.organizeMethod==0 : value = 'extensions'
        else: value = 'keywords'
        
        for folder in self.folders:
            cellNames.append(folder['name'])
            cellValues.append(folder[value])

        worksheet.data_validation('B2', {'validate': 'list',
                                  'source': ['POR EXTENSION', 'POR ETIQUETA'],
                                  'input_title': 'Metodo:',
                                  'input_message': 'Metodo con el cual se ordenaran los archivos'})

        worksheet.data_validation('B3', {'validate': 'list',
                                  'source': ['SI', 'NO'],
                                  'input_title': 'Mover a Carpeta Otros:',
                                  'input_message': 'Mover archivos no especificados a una carpeta por defecto'})

        for i, (name,value) in enumerate(zip(cellNames,cellValues)):
            cell = 'A'+str(i+1)
            sideCell = 'B'+str(i+1)

            worksheet.write(cell, name,bold)
            worksheet.write(sideCell, value)
                
            #print(name,value)

        worksheet.set_column(0, 0, max([len(name) for name in cellNames]))
        worksheet.set_column(1, 1, max([len(value) for value in cellValues]))
        
        #Closing...
        workbook.close()
        self.ok = True

# testOrganizer = FileOrganizer("D:\\Users\\JUAN OROZCO\\Desktop\\Test files",['f1','f2'],['png jpeg','mp4 wav'],0,['.py'],False)
# print(testOrganizer.folders)
# print('end')



# testSave = SaveFile()
# testSave.load(r"D:\Users\JUAN OROZCO\Desktop\testSave\descargasInfo.xlsx")

# if testSave.ok:
#     print('RUTA:',testSave.folderPath)
#     print('METODO:',testSave.organizeMethod)
#     print('MOVER A OTROS:',testSave.moveToDefault)
#     print('CARPETAS:',testSave.folders)

#     testSave.moveToDefault = True
#     testSave.save(r"D:\Users\JUAN OROZCO\Desktop\testSave\descargasInfo_True.xlsx")
#     if not testSave.ok: print(testSave.log)

# else:
#     print(testSave.log)


# s = SaveFile()
# s.load(r"D:\Users\JUAN OROZCO\Desktop\testSave\prueba4.xlsx")
# if s.ok:
#     print('RUTA:',s.folderPath)
#     print('METODO:',s.organizeMethod)
#     print('MOVER A OTROS:',s.moveToDefault)
#     print('CARPETAS:',s.folders)

#     folder = {'name':'pythonF','keywords':'python'}
#     s.folders.append(folder)

#     s.save(r"D:\Users\JUAN OROZCO\Desktop\testSave\prueba5.xlsx")

# else: print(s.log)
