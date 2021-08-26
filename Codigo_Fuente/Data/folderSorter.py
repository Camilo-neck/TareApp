import os
import shutil
import errno

import pkg_resources
pkg_resources.require("xlrd==1.2.0")
import xlrd
import xlsxwriter

def create_folders_list(folder_names,ext_tags,organize_method):
    folders = []
    for name,e in zip(folder_names,ext_tags):         
        folder = {}
        folder['name'] = name 
        if organize_method == 0: folder['extensions'] = e
        else: folder['keywords'] = e
        folders.append(folder)

    return folders

class FileOrganizer():
    def __init__(self,path,folder_names,ext_tags,organize_method,ignored_ext,move_to_default):
        self.default_folder = {'name' : 'Otros'}
        self.path = path
        self.organize_method = organize_method
        self.folders = create_folders_list(folder_names,ext_tags,organize_method)
        for folder in self.folders:
            if self.organize_method==0: folder['extensions'] = [f'.{ext}' for ext in folder['extensions'].split(' ')]
            else: folder['keywords'] = [keyword for keyword in folder['keywords'].split(' ')]

        self.ignored_ext = ignored_ext
        self.move_to_default = move_to_default
        self.log = ''

    def create_folders(self):
        #try to create the indicate folders
        folders_m = self.folders[:]
        if self.move_to_default == True: folders_m.append(self.default_folder)

        for folder in folders_m:
            name = folder['name']
            try:
                os.mkdir(os.path.join(self.path, name))
                print("Se ha creado la carpeta",name,"satisfacctoriamente")
            except OSError as e:
                if e.errno == errno.EEXIST: #if the folder already exist it will continue with the next folder
                    print("La carpeta",name,"ya existe")
                else: raise #if there is another error it will raise it (for example invalid name)
                
    def organize_file(self,file):

        file_name , ext = os.path.splitext(file)
        file = '\\'+file
        if ext in self.ignored_ext: #the ignored extensions won´t be moved to any folder
            self.log += "\nEl archivo " + file[1:] + " No se movio ya que este se encuentra en la lista de ignorados"
            return None

        for folder in self.folders:
            #depending on the method the condition to move the file will be different
            if self.organize_method == 0: condition = ext in folder['extensions']
            elif self.organize_method == 1:
                condition = False
                for keyword in folder['keywords']:
                    if keyword in file:
                        condition = True
                        break

            if condition:
                final_path = self.path + '/'+folder['name']
                try: shutil.move(self.path + file, final_path)
                except shutil.Error: self.log += "\nNo se pudo mover el archivo "+file[1:] #str(e) //// if there was an error when moving the file it will continue with the next file
                return None

        if self.move_to_default == True: #move the file to default folder if it wasn´t moved to any folder and if moveDefault == True
            final_path = self.path + '/'+self.default_folder['name']
            shutil.move(self.path + file, final_path)

    def organize_all_files(self):
        #try to sort all files, if one folder name is invalid it will stop the function via return None
        try: self.create_folders()
        except OSError as e:
            if e.errno == errno.EINVAL:
                self.log = "Una de las carpetas posee un nombre invalido"
                return None
            else: raise #on another error it will raise the error and closes the aplication (unexpected)
        else: 
            for file in os.listdir(self.path): 
                if not os.path.isdir(self.path+'//'+file): #if the file isn´t a folder it will try to sort it into a folder
                    print(">>>>>>>>>>FILE:",file)
                    self.organize_file(file)
                else: print(">>>>>>>>>>FOLDER:",file) #if the file is a folder it will be ignored

class SaveFile():
    def __init__(self):
        self.folder_path = ''
        self.organize_method = -1
        self.move_to_default = None
        self.folders = []
        self.log = ''
        self.ok = False
    
    def set_attributes(self, folder_path,folder_names,ext_tags,organize_method,move_to_default):
        self.folder_path = folder_path
        self.organize_method = organize_method
        self.move_to_default = move_to_default
        self.folders = create_folders_list(folder_names,ext_tags,organize_method)
    
    def load(self, load_path):
        if not os.path.isfile(load_path):
            self.ok = False
            self.log = 'El archivo iste en la ruta especificada'
            return None

        # Creating Excel document objects
        loc = (load_path)
        wb = xlrd.open_workbook(loc)
        sheet = wb.sheet_by_index(0)
        sheet.cell_value(0, 0)
        #Getting row number
        rows_count = sheet.nrows
        #get the Excel file information
        rows_list = []
        for x in range(rows_count): rows_list.append(sheet.row_values(x))

        folder_path = rows_list[0][1]
        is_default_file = folder_path == "_DEFAULT_FILE"
        if not os.path.isdir(folder_path) and not is_default_file:
            self.ok = False
            self.log = 'La ruta de la carpeta a ordenar no existe'
            return None


        str_method = rows_list[1][1]
        organize_method = (lambda str_method : 0 if str_method =='POR EXTENSION' else (1 if str_method =='POR ETIQUETA' else -1))(str_method)
        if organize_method == -1:
            self.ok = False
            self.log = 'Metodo invalido'
            return None

        str_move_to_default = rows_list[2][1]
        move_to_default = (lambda str_move_to_default: str_move_to_default=='SI')(str_move_to_default)
        
        folder_names = []
        ext_tags = []
        for row in rows_list[3:]:
            folder_names.append(row[0])
            ext_tags.append(row[1])

        self.set_attributes(folder_path, folder_names, ext_tags, organize_method, move_to_default)

        self.ok = True

    def save(self, save_path):#save_path must be non existing xlsx file
        #Creating and setting up Excel file
        if os.path.isfile(save_path):
            self.ok = False
            self.log = "El archivo de excel ya existe"
            return None
        new_exc = save_path
        #print('RUTA EXCEL:',new_exc)
        workbook = xlsxwriter.Workbook(new_exc)
        worksheet = workbook.add_worksheet()
        bold = workbook.add_format({'bold': True})
        cell_format = workbook.add_format()
        cell_format.set_align('fill')
        #Writting main information to the Excel document with indications
        cell_names = ["RUTA CARPETA","METODO","MOVER A OTROS   "]

        if self.organize_method==0 : method = 'POR EXTENSION'
        else: method = 'POR ETIQUETA'

        if self.move_to_default: to_default = 'SI'
        else: to_default = 'NO'

        cell_values = [self.folder_path,method,to_default]

        if self.organize_method==0 : value = 'extensions'
        else: value = 'keywords'
        
        for folder in self.folders:
            cell_names.append(folder['name'])
            cell_values.append(folder[value])

        worksheet.data_validation('B2', {'validate': 'list',
                                  'source': ['POR EXTENSION', 'POR ETIQUETA'],
                                  'input_title': 'Metodo:',
                                  'input_message': 'Metodo con el cual se ordenaran los archivos'})

        worksheet.data_validation('B3', {'validate': 'list',
                                  'source': ['SI', 'NO'],
                                  'input_title': 'Mover a Carpeta Otros:',
                                  'input_message': 'Mover archivos no especificados a una carpeta por defecto'})

        for i, (name,value) in enumerate(zip(cell_names,cell_values)):
            cell = 'A'+str(i+1)
            side_cell = 'B'+str(i+1)

            worksheet.write(cell, name,bold)
            worksheet.write(side_cell, value)
                
            #print(name,value)

        worksheet.set_column(0, 0, max([len(name) for name in cell_names]))
        worksheet.set_column(1, 1, max([len(value) for value in cell_values]))
        
        #Closing...
        workbook.close()
        self.ok = True