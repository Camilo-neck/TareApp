from os import system
import requests
from bs4 import BeautifulSoup
import wikipedia
from googlesearch import search
from random import randint

url = f'https://tioconejo.alwaysdata.net/resumidor/pc.php?'
saludo = "What do you want to do?"

# Get info from API
def get_info(texto = None, link = None):
    if link is None: args = {'texto': texto}  
    else : args = {'url': link}
    res = requests.post(url, data=args)
    text = str()
    if res.ok:
        print("\n----------------\n")
        soup = BeautifulSoup(res.text, 'html.parser')
        relevant = soup.find_all('span', id='L')
        for paragraph in relevant:
            text += paragraph.text + ' '
        return text
    return "Error"

token = '574018b10c4ac5e9689958eb'
# get info fron API 2
def get_info1():
    args = {'url': google_url()}
    res = requests.post('https://ssfy.sh/dev/synopsis@15f060e3/summarize', data=args)
    res = res.text.replace(',','')
    res = res.replace('[',' ')
    res = res.replace(']',' ')
    res = res.replace('"',' ')
    print(res)
    return 0

# Obtain url from google search
def google_url():
    google_query = input("What do you want to search for?: ")
    verify = True
    url_list = list(search(google_query, start=0, lang='en', num=15))
    exceptions = ["www.youtube.com", "mercadolibre", "linio", "olx", "amazon", "alibaba",]
    while True:
        index = randint(0,14)
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
def formatter(text):
    for i in range(10):
        text = text.replace(str(i), '')
    text = text.replace('[', '')
    text = text.replace(']', '')
    return text

# Make the query on wikipedia
def search_def(text):
    try:
        query = text
        print(query)
        wikipedia.set_lang('es')
        text = wikipedia.summary(query, 10)
        text = formatter(text)
        return text
    except wikipedia.exceptions.DisambiguationError as err:
        system('cls')
        print('------------------------')
        print("\nError. Ambiguous word, it is not possible to find a single definition. \n")
        print(f'{err}\n')
        print("Try option 2.")
        #main()

def main(text, opc = 1):

    if opc == 1:
        return get_info(texto=search_def(text))
    elif opc == 2:
        print(get_info(link=google_url()))
    elif opc == 3:
        exit()
    else:
        print('Incorrect option.')
    
    #get_info1()

if __name__ == '__main__':
    print(main("Estudiantes"))
