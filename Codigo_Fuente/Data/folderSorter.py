import os
import shutil
import errno

class FileOrganizer():
    def __init__(self,organizeMethod,path,folders,ignored_ext,moveToDefault):
        self.defaultFolder = {'name' : 'Otros'}
        self.organizeMethod = organizeMethod
        self.path = path
        self.folders = folders
        self.ignored_ext = ignored_ext
        self.moveToDefault = moveToDefault

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
            print("El archivo",file,"No se movio ya que este se encuentra en la lista de ignorados")
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
                except shutil.Error as e: print("No se pudo mover el archivo:",e) #if there was an error when moving the file it will continue with the next file
                return None

        if self.moveToDefault == True: #move the file to default folder if it wasn´t moved to any folder and if moveDefault == True
            final_path = self.path + '/'+self.defaultFolder['name']
            shutil.move(self.path + file, final_path)

    def organizeAllFiles(self):
        #try to sort all files, if one folder name is invalid it will stop the function via return 0
        try:
            self.createFolders()
        except OSError as e:
            if e.errno == errno.EINVAL:
                print("Nombre de carpeta invalido")
                return 0
            else: raise #on another error it will raise the error and closes the aplication (unexpected)
        else: 
            for file in os.listdir(self.path): 
                if not os.path.isdir(self.path+'//'+file): #if the file isn´t a folder it will try to sort it into a folder
                    print(">>>>>>>>>>FILE:",file)
                    self.organizeFile(file)
                else: print(">>>>>>>>>>FOLDER:",file) #if the file is a folder it will be ignored