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
        
    Get info from API
    def summarize(self, texto = None, link = None):
         if link is None: payload = {'texto': texto}
         else : payload = {'url': link}
         res = requests.post(self.__APIURL, data=payload)
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

    # def summarize(self, texto = None, link = None, sentences = 5):
    #    if texto == None: payload = {'key': '88f4300d2c9b101261ea613148ee4395',
    #            'url': link,
    #            'sentences' : sentences}
    #    else: payload = {'key': '88f4300d2c9b101261ea613148ee4395',
    #            'txt': texto,
    #            'sentences' : sentences}
    #    res = requests.post('https://api.meaningcloud.com/summarization-1.0', data=payload)
    
    #    if res.ok:
    #        return res.json()['summary']
    #    else:
    #        return "Unexpected Error."

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
