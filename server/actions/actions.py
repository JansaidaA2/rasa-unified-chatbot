from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from googletrans import Translator

translator = Translator()

class ActionTranslateAndRespond(Action):

    def name(self) -> Text:
        return "action_translate_and_respond"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        user_msg = tracker.latest_message.get('text')

        # Detect and translate message
        translated = translator.translate(user_msg, dest='en')
        translated_text = translated.text
        src_lang = translated.src

        # Print translation (for debug)
        print(f"Original: {user_msg} | Translated: {translated_text} | From: {src_lang}")

        # Respond in user’s language
        reply = f"You said: {translated_text}"
        translated_reply = translator.translate(reply, dest=src_lang).text

        dispatcher.utter_message(text=translated_reply)
        return []
