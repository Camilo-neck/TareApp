from dotenv import load_dotenv
import os
import openai

load_dotenv()

# Load your API key from an environment variable or secret management service
openai.api_key = os.getenv("OPENAI_API_KEY")

def summarized(query):
    query = query.replace("\n", '')
    try:
        response = openai.Completion.create(
            engine="curie",
            prompt=f"{query}\nResumen:",
            temperature=0.3,
            max_tokens=200,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0,
            stop=["\n"]
        )
        return (response["choices"][0]['text'])
    except openai.error.AuthenticationError:
        return "Error de autenticación. Por favor proveer un API key."

def keywords(query):
    try:
        response = openai.Completion.create(
                engine="davinci",
                prompt=f"Text: {query}\n\nKeywords:",
                temperature=0.3,
                max_tokens=200,
                top_p=1,
                frequency_penalty=0.8,
                presence_penalty=0,
                stop=["\n"]
                )
        response_list = response["choices"][0]['text'].split(',')
        clean_response = f'-{response_list[0]}'
        for key in response_list[1:]:
            clean_response += f'\t-{key:^10}'
        return clean_response
    except openai.error.AuthenticationError:
        return "Error de autenticación. Por favor proveer un API key."
