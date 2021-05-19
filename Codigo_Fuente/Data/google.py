from . import openaitest
from . consultant import *
from random import randint
from googlesearch import search

class Google(Consultant):
    def __init__(self):
        super().__init__()
        self.__url = ""

    def consult(self):
        if self.openai_response == True:
            return super().consult()  + openaitest.summarized(self.summarize(link = self.google_url(self.query))) + + f"\nObtenido de: {self.__url}\n" "\nResumen realizado con la tecnología GPT-3 de Open AI."
        else:
            return super().consult()  + self.summarize(link = self.google_url(self.query))+ f"\nObtenido de: {self.__url}\n"
        
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
        self.__url = url
        return url

    def __str__(self) -> str:
        return super().__str__() + "Google."