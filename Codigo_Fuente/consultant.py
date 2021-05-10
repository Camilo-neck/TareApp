from os import system
import requests
from bs4 import BeautifulSoup
import wikipedia
from googlesearch import search
from random import randint
import openaitest

saludo = "What do you want to do?"

class Consultant():
    def __init__(self):
        self.query = "Open AI"
        self.engine = "W"
        self.openai_response = False
        self.__APIURL = 'https://tioconejo.alwaysdata.net/resumidor/pc.php?'

    def consult(self):
        if self.engine == "W":
            if self.openai_response == True:
                return openaitest.summarized(self.summarize(texto = self.search_wiki_def(self.query)))
            else:
                return self.summarize(texto = self.search_wiki_def(self.query))
        if self.engine == "G":
            if self.openai_response == True:
                return openaitest.summarized(self.summarize(link = self.google_url(self.query)))
            else:
                return self.summarize(link = self.google_url(self.query))
        if self.engine == "U":
            if self.openai_response == True:
                return openaitest.summarized(self.summarize(link = self.query))
            else:
                return self.summarize(link = self.query)
        
    # Make the query on wikipedia
    def search_wiki_def(self, text):
        texto = ''
        #try:
        query = text
        print(query)
        try:
            wikipedia.set_lang('es')
            texto = wikipedia.summary(query, 10)
            texto = self.formatter(texto)
        except wikipedia.exceptions.DisambiguationError as err:
            texto = f'Error. Ambiguous word, it is not possible to find a single definition. \n{err}.'
        return texto

    # Get info from API
    def summarize(self, texto = None, link = None):
        if link is None: args = {'texto': texto}  
        else : args = {'url': link}
        res = requests.post(self.__APIURL, data=args)
        text = ""
        if res.ok:
            print("\n----------------\n")
            soup = BeautifulSoup(res.text, 'html.parser')
            container = soup.find('div', id="ideas_principales")
            table = container.find('table', class_='table')
            texto = table.find_all('td')
            clean_text = [v.text.strip() for v in texto]

            for paragraph in clean_text:
                text += paragraph + '. \n'
                
            return text
        return "Error"

    # Obtain url from google search
    def google_url(self, query):
        google_query = query
        verify = True
        url_list = list(search(google_query, start=0, lang='es', num=20))
        exceptions = ["www.youtube.com", "mercadolibre", "linio", "olx", "amazon", "alibaba",]
        while True:
            index = randint(0,19)
            url =url_list[index]
            for exception in exceptions:
                if exception in url:
                    verify = False
                    break
            if verify:
                break
        print(f"Obteined from: {url}")
        return url

    # Format the obtained text
    def formatter(self, text):
        for i in range(10):
            text = text.replace(str(i), '')
        text = text.replace('[', '')
        text = text.replace(']', '')
        return text

    def set_query(self, query):
        self.query = query
    
    def set_engine(self, engine):
        self.engine = engine

    def __str__(self) -> str:
        engine = ""
        if self.engine == "W":
            engine += "Wikipedia"
        elif self.engine == "G":
            engine += "Google (Feel Lucky)"
        elif self.engine == "U":
            engine += "your URL"
        else: 
            engine = "No Selected"
        return f"Your actual query is {self.query} and we are gonna search by {engine}"

def main():
    global saludo

    print(f"\n{saludo}")

    consult = Consultant()
    # consult.set_query("https://es.wikipedia.org/wiki/OpenAI")
    # consult.set_engine("U")
    consult.openai_response = 0
    result = consult.consult()
    print(result)
    # print(consult.__APIURL)

if __name__ == '__main__':
    main()