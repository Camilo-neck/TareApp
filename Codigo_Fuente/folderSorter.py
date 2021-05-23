import os
import shutil

import errno

defaultFolder = {
    'name' : 'Otros',
}

def createFolders(path,f, moveToDefault = True):
    folders = f[:]
    if moveToDefault == True: folders.append(defaultFolder)

    for folder in folders:
        name = folder['name']
        try:
            os.mkdir(os.path.join(path, name))
            print("Se ha creado la carpeta",name,"satisfacctoriamente")
        except OSError as e:
            print("La carpeta",name,"ya existe")
            if e.errno != errno.EEXIST:
                raise
            

def sort_file(sortMethod, ruta, file, ext, folders, moveToDefault = True,ignoredExt = []):

    if ext in ignoredExt:
        print("El archivo",file,"No se movio ya que este se encuentra en la lista de ignorados")
        return None

    for folder in folders:
        if sortMethod == 0: condition = ext in folder['extensions']
        elif sortMethod == 1:
            condition = False
            for keyword in folder['keywords']:
                if keyword in file:
                    condition = True
                    break

        if condition:
            final_path = ruta + '/'+folder['name']
            shutil.move(ruta + file, final_path)
            return None

    if moveToDefault == True:
        #print("El archivo",file,'fue movido a la carpeta otros')
        final_path = ruta + '/'+defaultFolder['name']
        shutil.move(ruta + file, final_path)

def sortAllFiles(sortMethod,ruta,folders,ignored_ext,moveToDefault = True):
    createFolders(ruta, folders, moveToDefault)
    for file in os.listdir(ruta):
        file_name , ext = os.path.splitext(file)
        if not os.path.isdir(ruta+'//'+file):
            print(">>>>>>>>>>FILE:",file)
            try:
                sort_file(sortMethod,ruta,'\\'+file, ext, folders, moveToDefault = moveToDefault, ignoredExt = ignored_ext)
            except:
                print("No se pudo mover el archivo:",file)

        else:
            print(">>>>>>>>>>FOLDER:",file)
