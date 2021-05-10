from dotenv import load_dotenv
import os
import openai

load_dotenv()

# Load your API key from an environment variable or secret management service
openai.api_key = os.getenv("OPENAI_API_KEY")

def summarized(query):
    response = openai.Completion.create(
        engine="curie",
        prompt=f"{query}\ntl;dr:",
        temperature=0.3,
        max_tokens=800,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
        stop=["\n"]
    )
    #print(response["choices"][0]['text'])
    return (response["choices"][0]['text'])