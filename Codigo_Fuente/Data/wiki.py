from . import openaitest
from . consultant import *
import wikipedia

class Wiki(Consultant):
    def __init__(self):
        super().__init__()

    def consult(self):
        if self.openai_response == True:
            return super().consult() + \
                openaitest.summarized(self.summarize(texto = self.search_wiki_def(self.query), sentences=20)) + \
                "\n\nResumen realizado con la tecnología GPT-3 de Open AI."
        else:
            return super().consult() + self.summarize(texto = self.search_wiki_def(self.query))
        
    # Make the query on wikipedia
    def search_wiki_def(self, text):
        texto = ''
        try:
            query = text
            wikipedia.set_lang('es')
            texto = wikipedia.summary(query, 10)
            return self.formatter(texto)
        except wikipedia.exceptions.DisambiguationError as err:
            return f'Error. Ambiguous word, it is not possible to find a single definition. \n{err}.'

    def __str__(self) -> str:
        return super().__str__() + "Wikipedia."