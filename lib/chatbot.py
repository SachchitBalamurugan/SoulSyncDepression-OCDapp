#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

nltk.download('vader_lexicon')

# Create a SentimentIntensityAnalyzer object
sia = SentimentIntensityAnalyzer()

# Extend the lexicon with custom words and phrases
sia.lexicon.update({
    'life': -1.0,   # Adjust the sentiment score as needed
    'depressed': -2.0,  # Example: 'depressed' is given a more negative score
    'hopeless': -2.0,  # Example: 'hopeless' is given a more negative score
})

def analyze_sentiment(text):
    # Tokenize the text into words
    words = text.lower().split()
    
    # Initialize sentiment score
    sentiment_score = 0.0
    
    # Check if both "quit" and "life" are in the same sentence
    if 'quit' in words and 'life' in words:
        sentiment_score = -3.0
    
    # Check if both "quit" and "life" are in the same sentence
    if 'hate' in words and 'life' in words:
        sentiment_score = -3.0
    
    # Check if both "quit" and "life" are in the same sentence
    if 'pressure' in words and 'handle' in words and ("can't" in words or 'can not' in words):
        sentiment_score = -3.0
    
     # Check if both "quit" and "life" are in the same sentence
    if 'pressure' in words and 'unable' in words and ("can't" in words or 'can not' in words or "not" in words):
        sentiment_score = -3.0
    
    # Check if both "quit" and "life" are in the same sentence
    if 'quit' in words and 'want' in words and 'to' in words:
        sentiment_score = -3.0
    
    # Use the SentimentIntensityAnalyzer to analyze sentiment
    sentiment = sia.polarity_scores(text)
    
    # Update sentiment score if the VADER sentiment is more negative
    if sentiment['compound'] < sentiment_score:
        sentiment_score = sentiment['compound']
    
    if sentiment_score <= -3.0:
        print("Chatbot: Consider contacting a suicide helpline or therapist for immediate support.")
    
    if sentiment_score <= -0.3 and sentiment_score > -3.0:
        print("Chatbot: I'm really sorry to hear that you're feeling this way. It's important to talk to someone who can help, like a mental health professional. You're not alone.")
    
    if sentiment_score <= 0.0 and sentiment_score >= -0.3:
        print("Chatbot:I am so sorry. You seem to be a little depressed.")
    
    
    # Return the overall sentiment score
    return f"This text appears to express depressive thoughts. (Sentiment Score: {sentiment_score})"

def chat_bot():
    print("Hello! I'm your chatbot. You can type your thoughts, and I'll analyze the sentiment.")
    while True:
        user_input = input("You: ")
        if user_input.lower() == "exit":
            print("Chatbot: Goodbye!")
            break
        sentiment_result = analyze_sentiment(user_input)
        print("Chatbot:", sentiment_result)

if __name__ == "__main__":
    chat_bot()


# In[ ]:




