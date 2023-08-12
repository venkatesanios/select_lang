import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': {
          'hello': 'Hello World',
          'message': 'Welcome to Proto Coders Point',
          'title': 'Flutter Language - Localization',
          'sub': 'Subscribe Now',
          'changelang': 'Change Language',
          'title2': 'Second Page',
          'Next': 'Next',
        },
        //HINDI LANGUAGE
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
          'message': 'प्रोटो कोडर प्वाइंट में आपका स्वागत है',
          'title': 'स्पंदन भाषा - स्थानीयकरण',
          'subscribe': 'सब्सक्राइब',
          'changelang': 'भाषा बदलो',
          'title2': 'दूसरा पेज',
          'Next': 'अगला',
        },
        //KANNADA LANGUAGE
        'kn_IN': {
          'hello': 'ಹಲೋ ವರ್ಲ್ಡ್',
          'message': 'ಪ್ರೋಟೋ ಕೋಡರ್ ಪಾಯಿಂಟ್‌ಗೆ ಸುಸ್ವಾಗತ',
          'title': 'ಬೀಸು ಭಾಷೆ - ಸ್ಥಳೀಕರಣ',
          'subscribe': 'ವಂತಿಗೆ ಕೊಡು',
          'changelang': 'ಭಾಷೆ ಬದಲಿಸಿ',
          'title2': 'ಎರಡನೇ ಪುಟ',
          'Next': 'ಮುಂದೆ',
        },
        //Tamil
        'ta_IN': {
          'hello': 'வணக்கம் ',
          'message': 'ஓரோ பாசனத்திற்கு வரவேற்கிறோம்',
          'title': 'மொழி - உள்ளூர்மயமாக்கல்',
          'subscribe': 'சந்தா செலுத்து',
          'changelang': 'மொழியை மாற்றவும்',
          'title2': 'இரண்டாவது பக்கம்',
          'Next': 'அடுத்து',
        }
      };
}

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
        },
        'ta_IN': {
          'hello': 'வணக்கம்',
        }
      };
}
