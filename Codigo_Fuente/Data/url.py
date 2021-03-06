from . import openai
from . consultant import *

class Url(Consultant):
    def __init__(self):
        super().__init__()

    def consult(self):
        if self.openai_response == True:
            return super().consult() + \
                openai.summarized(self.summarize(link = self.query, sentences=20)) + \
                "\n\nResumen realizado con la tecnología GPT-3 de Open AI.", openai.keywords(self.summarize(link = self.query, sentences=20))
        else:
            return super().consult() + self.summarize(link = self.query), self.words(link = self.query)

    def __str__(self) -> str:
        return super().__str__() + "your own URL."