from PyPDF2 import PdfFileReader, PdfFileWriter

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
