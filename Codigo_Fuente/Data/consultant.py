from os import system
import requests
from bs4 import BeautifulSoup

saludo = "What do you want to do?"

class Consultant():
    def __init__(self):
        self.query = "Open AI"
        self.openai_response = False
        self.__APIURL = 'https://tioconejo.alwaysdata.net/resumidor/pc.php?'

    def consult(self):
        return "Su resultado es:\n"
        
    # Get info from API
    def summarize(self, texto = None, link = None):
        if link is None: args = {'texto': texto}  
        else : args = {'url': link}
        res = requests.post(self.__APIURL, data=args)
        text = ""
        if res.ok:
            soup = BeautifulSoup(res.text, 'html.parser')
            container = soup.find('div', id="ideas_principales")
            table = container.find('table', class_='table')
            texto = table.find_all('td')
            clean_text = [v.text.strip() for v in texto]

            for paragraph in clean_text:
                text += paragraph + '. \n'
                
            return text
        return "Error"

    # Format the obtained text
    def formatter(self, text):
        for i in range(10):
            text = text.replace(str(i), '')
        text = text.replace('[', '')
        text = text.replace(']', '')
        return text

    def set_query(self, query):
        self.query = query

    def set_openai(self, openai):
        self.openai_response = openai


    def __str__(self) -> str:
        return f"Your actual query is {self.query} and we are gonna search by "

def main():
    global saludo


if __name__ == '__main__':
    main()
