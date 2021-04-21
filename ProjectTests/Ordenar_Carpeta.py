import os
import shutil

import errno

img_ext = ['.jpg','.png','.jpeg']
video_ext = ['.mp4','.avi','.mov','.mkv','.gif']
audio_ext = ['.mp3','.wav','.aac','.ogg']
text_ext = ['.txt','.pdf']
office_ext = ['.docx','.doc','.pptx','.xlsx']
compresed_ext = ['.rar','.zip']

ignored_ext = [".py"]

extensions = [img_ext,video_ext,audio_ext,text_ext,compresed_ext,office_ext]
names =['Imagenes','Videos','Musica y Audios','Archivos de Texto','Carpetas comprimidas','Archivos de Office','Otros']

def verify_folder(ruta,name):
    try:
        os.mkdir(os.path.join(ruta, name))
        print("Se ha creado la carpeta",name,"satisfacctoriamente")
    except OSError as e:
        #print("La carpeta",name,"ya existe")
        if e.errno != errno.EEXIST:
            raise

def sort_file(ruta, file, ext):
    if ext in img_ext:
        final_path = ruta + '/Imagenes'
    elif ext in video_ext:
        final_path = ruta + '/Videos'
    elif ext in audio_ext:
        final_path = ruta + '/Musica y Audios'
    elif ext in text_ext:
        final_path = ruta + '/Archivos de Texto'
    elif ext in compresed_ext:
        final_path = ruta + '/Carpetas comprimidas'
    elif ext in office_ext:
        final_path = ruta + '/Archivos de Office'

    elif ext in ignored_ext:
        print("El archivo",file,"No se movio ya que este se encuentra en la lista de ignorados")
        return None

    else:
        final_path = ruta + '/Otros'
    
    #print('\n'+final_path,ruta+file,'\n')
    shutil.move(ruta + file, final_path)

def main():

    print("Seleccione una opcion\n[1] Ingresar ruta especifica\n[2] Ordenar carpeta de descargas\n[3] Ordenar carpeta actual (Donde se encuentra el archivo Ordenar_Carpeta.py)")
    opc = input("\n>>")

    if opc == '1':
        while True:
            print("Ingrese la ruta de la carpeta a ordenar")
            ruta = input("\n>>")

            if not os.path.isdir(ruta):
                print("La ruta especificada no corresponde a ningun directorio valido")
            else:
                break
                
    elif opc == '2':
        ruta = "C:\\Users\\USER\\Downloads"
    elif opc =='3':
        ruta = os.getcwd()

    for name in names:
        verify_folder(ruta,name)
    
    print("\nEsta apunto de organizar su carpeta")
    opc = input("Ingrese [1] para continuar o cualquier caracter para salir: ")
    if opc == '1':
        print("Ordenando...")
        for file in os.listdir(ruta):
            file_name , ext = os.path.splitext(file)
            if ext != '':
                try:
                    sort_file(ruta,'\\'+file, ext)
                except:
                    print("No se pudo mover el archivo:",file)
    
        input("\nProceso Terminado, presione enter para salir")

main()