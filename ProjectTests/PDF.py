from PyPDF2 import PdfFileReader, PdfFileWriter

import tkinter as tk
from tkinter import Tk     # from tkinter import Tk for Python 3.x
from tkinter import ttk
from tkinter.filedialog import askopenfilename
from tkinter import messagebox
from tkinter import simpledialog

def merge_pdfs(paths,output_name):
    pdf_writer = PdfFileWriter()

    for path in paths:
        pdf_reader = PdfFileReader(path)
        for page in range(pdf_reader.getNumPages()):
            pdf_writer.addPage(pdf_reader.getPage(page))

    with open(output_name, 'wb') as out:
        pdf_writer.write(out)

def extract_page(path,page):
    page -= 1
    pdf_writer = PdfFileWriter()
    pdf_reader = PdfFileReader(path)
    pdf_writer.addPage(pdf_reader.getPage(page))

    if ".pdf" in path:
        path = path.replace(".pdf",'')
    name = path

    with open(name+"_pag_"+str(page+1)+'.pdf', 'wb') as out:
        pdf_writer.write(out)

def insert_page(path1,path2,pageNum_Writter,pageNum_Getter,output_name):
    NewPage = PdfFileReader(path2).getPage(pageNum_Getter-1)

    pdf_writer = PdfFileWriter()
    pdf_reader = PdfFileReader(path1)

    for page in range(pdf_reader.getNumPages()):
        if page == pageNum_Writter-1:
            pdf_writer.addPage(NewPage)
        pdf_writer.addPage(pdf_reader.getPage(page))

    with open(output_name, 'wb') as out:
        pdf_writer.write(out)

def swap_pages(path,page1,page2,output_name):
    pdf_writer = PdfFileWriter()
    pdf_reader = PdfFileReader(path)
    
    for page in range(pdf_reader.getNumPages()):
        if page == page1-1:
            pdf_writer.addPage(pdf_reader.getPage(page2-1))
            continue
        
        if page == page2-1:
            pdf_writer.addPage(pdf_reader.getPage(page1-1))
            continue

        pdf_writer.addPage(pdf_reader.getPage(page))
    
    with open(output_name, 'wb') as out:
        pdf_writer.write(out)

def get_file():
    Tk().withdraw() # we don't want a full GUI, so keep the root window from appearing
    filename = askopenfilename() # show an "Open" dialog box and return the path to the selected file
    return filename

def verify_pdf(name):

    while True:
        try:
            pdf_reader = PdfFileReader(name)
            break
        except:
            messagebox.showwarning("PDF APP","El archivo seleccionado no es de tipo pdf")
            name = get_file()
            if name == '':
                break

    return name

class app():
    def __init__(self):
        self.root = tk.Tk()
        self.root.title('PDF APP')
        self.root.geometry('220x100')

        self.label = tk.Label(self.root, text='PDF APP', font=('Impact', 15))
        self.label.grid(column=0, row=0)

        self.merge_bttn = tk.Button(self.root,command = self.merge_opc,text='Unir PDF',bg="Blue",fg="white")
        self.merge_bttn.grid(column=0,row=1)

        self.extract_bttn = tk.Button(self.root,command = self.extract_opc,text='Extraer pagina',bg="Blue",fg="white")
        self.extract_bttn.grid(column=0,row=2)

        self.insert_bttn = tk.Button(self.root,command = self.insert_opc,text='Insertar pagina',bg="Blue",fg="white")
        self.insert_bttn.grid(column=1,row=1)

        self.swap_bttn = tk.Button(self.root,command = self.swap_opc,text='Intercambiar paginas',bg="Blue",fg="white")
        self.swap_bttn.grid(column=1,row=2)
        
        self.root.mainloop()

    def ask_string(self,msg):
        while True:
            string = simpledialog.askstring(title="PDF APP",prompt=msg)
            if string == '':
                messagebox.showwarning("PDF APP","No puede dejar el campo vacio")
            elif string == None:
                return None
            else:
                break

        return string
    
    def ask_numPag(self,msg):
        while True:
            try:
                pag = self.ask_string(msg)
                if pag == None:
                    return None
                pag = int(pag)
                if pag > 0:
                    break
                else:
                    messagebox.showwarning("PDF APP","Ingrese un numero de pagina valido")
            except:
                messagebox.showwarning("PDF APP","Ingrese un numero de pagina valido")
        return pag


    def merge_opc(self):
        messagebox.showinfo("PDF APP","Seleccione los pdf a unir")
        self.p = ' '
        self.paths = []
        self.i=1
        while self.p != '':
            if self.i>=3:
                self.add_more = messagebox.askokcancel("PDF APP","Desea agregar otro pdf?")
                if self.add_more == False:
                    break

            self.p = get_file()
            if self.p == '':
                return None #Salir de la funcion (cancelar)        
            self.p = verify_pdf(self.p)
            if self.p == '':
                return None

            self.paths.append(self.p)

            self.i+=1
    
        self.output_name = self.ask_string("Nombre del nuevo PDF")
        if self.output_name == None:
            return None
        if ".pdf" not in self.output_name:
                self.output_name += ".pdf"

        merge_pdfs(self.paths,self.output_name)
    
    def extract_opc(self):
        self.name = get_file()
        if self.name == '':
            return None
        self.name = verify_pdf(self.name)
        if self.name == '':
            return None

        self.page = self.ask_numPag("Ingrese la pagina a extraer")
        if self.page == None:
            return None
        
        extract_page(self.name,self.page)
    
    def insert_opc(self):
        messagebox.showinfo("PDF APP","Seleccione el PDF donde se insertara la pagina")
        self.f1 = get_file()
        if self.f1 == '':
            return None
        self.f1 = verify_pdf(self.f1)
        if self.f1 == '':
            return None

        messagebox.showinfo("PDF APP","Seleccione el PDF del cual se extraera la pagina")
        self.f2 = get_file()
        if self.f2 == '':
            return None
        self.f2 = verify_pdf(self.f2)
        if self.f2 == '':
            return None

        self.wherePage = self.ask_numPag("Numero de la pagina donde se insertara la nueva pagina")
        if self.wherePage == None:
            return None
        self.getPage = self.ask_numPag("Numero de la pagina a extraer")
        if self.getPage == None:
            return None

        self.output_name = self.ask_string("Nombre del nuevo PDF")
        if self.output_name == None:
            return None

        if ".pdf" not in self.output_name:
                self.output_name += ".pdf"

        insert_page(self.f1,self.f2,self.wherePage,self.getPage,self.output_name)
    
    def swap_opc(self):
        messagebox.showinfo("PDF APP","Seleccione el PDF")
        self.p1 = get_file()
        if self.p1 == '':
            return None
        self.p1 = verify_pdf(self.p1)
        if self.p1 == '':
            return None
            
        self.page1 = self.ask_numPag("Pagina [1] a intercambiar")
        if self.page1 == None:
            return None
        
        self.page2 = self.ask_numPag("Pagina [2] a intercambiar")
        if self.page2 == None:
            return None


        self.output_name = self.ask_string("Nombre del nuevo PDF")
        if self.output_name == None:
            return None
        if ".pdf" not in self.output_name:
                self.output_name += ".pdf"

        swap_pages(self.p1,self.page1,self.page2,self.output_name)

def main():
    window = app() 

if __name__ == "__main__":
    main()
