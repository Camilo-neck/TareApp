from . import openaitest
from . consultant import *

class Url(Consultant):
    def __init__(self):
        super().__init__()

    def consult(self):
        if self.openai_response == True:
            return super().consult() + openaitest.summarized(self.summarize(link = self.query)) + "\n\nResumen realizado con la tecnología GPT-3 de Open AI."
        else:
            return super().consult() + self.summarize(link = self.query)

    def __str__(self) -> str:
        return super().__str__() + "your own URL."