from . import openaitest
from . consultant import *

class MyText(Consultant):
    def __init__(self):
        super().__init__()

    def consult(self):
        if self.openai_response == True:
            return super().consult() + \
                openaitest.summarized(self.summarize(texto = self.query, sentences=20)) + \
                "\n\nResumen realizado con la tecnología GPT-3 de Open AI.", openaitest.keywords(self.query)
        else:
            return super().consult() + self.summarize(texto = self.query), self.words(texto=self.query)

    def __str__(self) -> str:
        return super().__str__() + "your own URL."