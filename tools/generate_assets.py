import json
import os

os.makedirs('assets/passages', exist_ok=True)
os.makedirs('assets/curriculum', exist_ok=True)
os.makedirs('assets/practice', exist_ok=True)
os.makedirs('assets/config', exist_ok=True)
os.makedirs('assets/audio_prompts', exist_ok=True)
os.makedirs('assets/images', exist_ok=True)

# 1. assets/config/thresholds.json
thresholds = {'version': '0.3.0',
 'status': 'provisional',
 'note': 'All thresholds, levels, weights and timings are provisional Samajh choices, not official standards, and are '
         'to be calibrated with teachers in the pilot.',
 'noise': {'check_duration_seconds': 3,
           'max_ambient_amplitude_ratio': 0.25,
           'warning_message_en': 'The room is too noisy. Please move to a quieter corner for an accurate check.',
           'warning_message_hi': 'कमरे में बहुत शोर है। कृपया शांत जगह पर जाएं ताकि जांच सही हो सके।'},
 'security': {'passcode_length': 6,
              'auto_lock_seconds': 120,
              'max_attempts_before_backoff': 3,
              'initial_backoff_seconds': 30,
              'backoff_multiplier': 2,
              'max_backoff_seconds': 300,
              'pbkdf2_iterations': 10000},
 'retention': {'audio_retention_hours': 24, 'delete_audio_on_marking_save': True},
 'scoring': {'accuracy_benchmark_ratio': 0.9,
             'class3_comprehension_pass_ratio': 0.75,
             'class2_comprehension_pass_ratio': 0.66,
             'general_comprehension_pass_ratio': 0.7,
             'dictation_item_count': 5,
             'max_timer_cap_seconds': 300,
             'lead_in_trim_seconds': 1.0,
             'correct_first_try': 1.0,
             'wrong_to_right': 0.75,
             'right_to_wrong': 0.0,
             'three_plus_changes_multiplier': 0.5,
             'fast_tap_flag_ms': 1000,
             'skip_is_neutral': True},
 'word_check_levels': {'1': {'level': 1,
                             'name_en': 'Sound & Word Recognition',
                             'name_hi': 'ध्वनि व शब्द पहचान',
                             'min_items': 4,
                             'max_items': 6,
                             'promotion_threshold': 0.75,
                             'expected_time_ms': 5000,
                             'status': 'provisional',
                             'items': 4},
                       '2': {'level': 2,
                             'name_en': 'Spelling & Matra Choice',
                             'name_hi': 'वर्तनी व मात्रा चयन',
                             'min_items': 4,
                             'max_items': 6,
                             'promotion_threshold': 0.75,
                             'expected_time_ms': 6000,
                             'status': 'provisional',
                             'items': 4},
                       '3': {'level': 3,
                             'name_en': 'Sentence Level & Writing Position',
                             'name_hi': 'वाक्य स्तर व लेखन स्थिति',
                             'min_items': 4,
                             'max_items': 6,
                             'promotion_threshold': 0.7,
                             'expected_time_ms': 8000,
                             'status': 'provisional',
                             'items': 4},
                       '4': {'level': 4,
                             'name_en': 'Meaning & Inference',
                             'name_hi': 'अर्थ व अनुमान',
                             'min_items': 4,
                             'max_items': 6,
                             'promotion_threshold': 0.7,
                             'expected_time_ms': 10000,
                             'status': 'provisional',
                             'items': 4}},
 'groups': {'group_1_on_track': {'code': 'G1',
                                 'name_en': 'On track',
                                 'name_hi': 'सही गति और समझ',
                                 'meaning_en': 'Reads accurately and understands the text well.',
                                 'meaning_hi': 'सटीक रूप से पढ़ता है और कहानी को अच्छी तरह समझता है।'},
            'group_2_understands_needs_reading': {'code': 'G2',
                                                  'name_en': 'Understands, needs help reading words',
                                                  'name_hi': 'समझता है, शब्द पढ़ने में मदद चाहिए',
                                                  'meaning_en': 'Understands the story when read or heard, but '
                                                                'decoding holds them back.',
                                                  'meaning_hi': 'कहानी समझ में आती है, लेकिन अक्षरों और मात्राओं को '
                                                                'पहचानने में समय लगता है।'},
            'group_3_reads_needs_understanding': {'code': 'G3',
                                                  'name_en': 'Reads words, needs help understanding',
                                                  'name_hi': 'शब्द पढ़ता है, समझ में मदद चाहिए',
                                                  'meaning_en': 'Decodes words accurately but misses the why and how.',
                                                  'meaning_hi': 'अक्षर सही पढ़ता है, लेकिन क्यों और कैसे वाले सवालों '
                                                                'में अटकता है।'},
            'group_4_needs_help_both': {'code': 'G4',
                                        'name_en': 'Needs help with both',
                                        'name_hi': 'पढ़ने और समझने दोनों में मदद चाहिए',
                                        'meaning_en': 'Needs focused practice in both word decoding and story '
                                                      'comprehension.',
                                        'meaning_hi': 'शब्द पहचान और कहानी की समझ दोनों पर एक साथ काम करने की आवश्यकता '
                                                      'है।'}},
 'weighted_marking': {'status': 'provisional',
                      'explanation_en': 'Marks for an answer = credit (1 right first time, 0.75 corrected to right, '
                                        'half again for 3+ changes) x level weight x time factor. Time factor is 1 up '
                                        'to the expected time and falls in a straight line to 0.5 at 3x the expected '
                                        'time.',
                      'explanation_hi': 'उत्तर के अंक = श्रेय (पहली बार सही 1, सुधारकर सही 0.75, 3 से अधिक बदलाव पर '
                                        'आधा) x स्तर का भार x समय गुणक। अपेक्षित समय तक समय गुणक 1 है, फिर 3 गुना समय '
                                        'पर 0.5 तक घटता है।',
                      'level_weights': {'1': 1, '2': 2, '3': 3, '4': 4},
                      'time_decay_end_multiple': 3.0,
                      'time_decay_floor': 0.5,
                      'promotion_uses_right_answers_only': True,
                      'start_level': 1,
                      'stop_at_first_level_not_passed': True},
 'typing_levels': {'1': {'level': 1,
                         'name_en': 'Simple words',
                         'name_hi': 'सरल शब्द',
                         'items': 3,
                         'min_items': 3,
                         'promotion_threshold': 0.66,
                         'expected_time_ms': 20000,
                         'status': 'provisional'},
                   '2': {'level': 2,
                         'name_en': 'Words with matras',
                         'name_hi': 'मात्रा वाले शब्द',
                         'items': 3,
                         'min_items': 3,
                         'promotion_threshold': 0.66,
                         'expected_time_ms': 30000,
                         'status': 'provisional'},
                   '3': {'level': 3,
                         'name_en': 'Half letters and bindu',
                         'name_hi': 'आधे अक्षर और बिंदु',
                         'items': 3,
                         'min_items': 3,
                         'promotion_threshold': 0.66,
                         'expected_time_ms': 40000,
                         'status': 'provisional'}},
 'question_levels': {'status': 'provisional',
                     'type_to_level': {'fact': 1, 'word_meaning': 2, 'why_how': 3, 'cause_effect': 3, 'main_idea': 4},
                     'pass_ratio': 0.5,
                     'expected_time_ms': 30000},
 'self_rating': {'status': 'provisional',
                 'after': ['reading_aloud', 'each_word_check_item', 'each_typed_word', 'each_teacher_question'],
                 'shown_to_child': False,
                 'note': "The child's thumbs up or down is shown only to the teacher, beside the real result."}}

with open('assets/config/thresholds.json', 'w', encoding='utf-8') as f:
    json.dump(thresholds, f, indent=2, ensure_ascii=False)

# 2. assets/curriculum/benchmarks.json
benchmarks = {
    "version": "1.0",
    "updated_at": "2026-10-21",
    "official_sources": [
        "NCERT Foundational Learning Study (FLS) 2022",
        "Ministry of Education NIPUN Bharat Guidelines 2021",
        "NCERT Learning Outcomes at the Foundational Stage 2025",
        "NCERT Learning Outcomes at the Elementary Stage 2017",
        "Basic Shiksha Parishad Uttar Pradesh NIPUN Tables & Class 3 Guide",
        "RSCERT Udaipur Hindi Teacher Guides 2025"
    ],
    "grades": {
        "1": {
            "grade": 1,
            "has_official_speed_target": False,
            "official_target_text_en": "Reads short sentences of 4 to 5 simple words with age-appropriate vocabulary.",
            "official_target_text_hi": "4 से 5 सरल शब्दों वाले छोटे वाक्य सही उच्चारण के साथ पढ़ता है।",
            "min_words_per_minute": None,
            "max_words_per_minute": None,
            "target_wpm": None,
            "accuracy_target_pct": 85,
            "comprehension_target_ratio": "2/3",
            "source_label": "NIPUN Bharat Guidelines 2021 (Lakshya Grade 1)",
            "explanation_en": "No official numerical reading-speed target. Progress is compared with the child's own earlier checks.",
            "explanation_hi": "कक्षा 1 के लिए कोई निश्चित गति संख्या नहीं है; बच्चे की प्रगति की तुलना उसके पहले के प्रयासों से की जाती है।"
        },
        "2": {
            "grade": 2,
            "has_official_speed_target": True,
            "official_target_text_en": "45 to 60 correct words per minute with meaning.",
            "official_target_text_hi": "45 से 60 शब्द प्रति मिनट की गति से अर्थ के साथ पढ़ता है (उत्तर प्रदेश: कम से कम 45 शब्द)।",
            "min_words_per_minute": 45,
            "max_words_per_minute": 60,
            "target_wpm": 45,
            "accuracy_target_pct": 90,
            "comprehension_target_ratio": "3/4",
            "source_label": "NIPUN Lakshya (Grade 2); UP Basic Shiksha H206",
            "explanation_en": "NIPUN target table specifies 45-60 wpm. UP state guideline specifies at least 45 wpm.",
            "explanation_hi": "निपुण लक्ष्य के अनुसार 45-60 शब्द प्रति मिनट। उत्तर प्रदेश निर्देशानुसार न्यूनतम 45 शब्द।"
        },
        "3": {
            "grade": 3,
            "has_official_speed_target": True,
            "official_target_text_en": "At least 60 correct words per minute with comprehension (answers at least 3 out of 4 questions correctly). FLS 2022 meets band: 35-54 wpm (Hindi).",
            "official_target_text_hi": "कम से कम 60 शब्द प्रति मिनट समझ के साथ (4 में से 3 प्रश्नों का सही उत्तर)। FLS 2022 स्तर: 35-54 शब्द प्रति मिनट (हिंदी)।",
            "min_words_per_minute": 60,
            "max_words_per_minute": 90,
            "target_wpm": 60,
            "fls_meets_min": 35,
            "fls_meets_max": 54,
            "accuracy_target_pct": 90,
            "comprehension_target_ratio": "3/4",
            "source_label": "NIPUN Lakshya Grade 3; NCERT FLS 2022; UP H306, H308",
            "explanation_en": "National NIPUN benchmark is 60+ cwpm with comprehension. NCERT FLS 2022 benchmark categorizes 35 to 54 cwpm in Hindi as 'Meets global proficiency'. Both standards are clearly displayed.",
            "explanation_hi": "राष्ट्रीय निपुण लक्ष्य 60+ शब्द/मिनट समझ के साथ है। एनसीईआरटी FLS 2022 के अनुसार 35 से 54 शब्द/मिनट 'मानक के अनुरूप' श्रेणी में आता है।"
        },
        "4": {
            "grade": 4,
            "has_official_speed_target": False,
            "official_target_text_en": "Reads age-appropriate narrative and informative texts with comprehension and self-correction.",
            "official_target_text_hi": "कक्षा स्तर के गद्यांश को समझ के साथ और विराम चिह्नों का ध्यान रखते हुए पढ़ता है।",
            "min_words_per_minute": None,
            "max_words_per_minute": None,
            "target_wpm": None,
            "accuracy_target_pct": 92,
            "comprehension_target_ratio": "3/4",
            "source_label": "NCERT Learning Outcomes Elementary Stage (2017)",
            "explanation_en": "No official numerical speed number in government guidelines for Class 4. Evaluated against child's baseline and comprehension.",
            "explanation_hi": "कक्षा 4 के लिए कोई आधिकारिक गति संख्या निर्धारित नहीं है। प्रगति की तुलना बच्चे के पुराने रिकॉर्ड से की जाती है।"
        },
        "5": {
            "grade": 5,
            "has_official_speed_target": False,
            "official_target_text_en": "Reads diverse texts with critical thinking, inference, and vocabulary grasp.",
            "official_target_text_hi": "विविध पाठ्य सामग्री को पढ़कर मुख्य विचार और निष्कर्ष निकालता है।",
            "min_words_per_minute": None,
            "max_words_per_minute": None,
            "target_wpm": None,
            "accuracy_target_pct": 95,
            "comprehension_target_ratio": "3/4",
            "source_label": "NCERT Learning Outcomes Elementary Stage (2017)",
            "explanation_en": "No official numerical speed target for Class 5. Progress is compared with the child's own earlier checks.",
            "explanation_hi": "कक्षा 5 के लिए कोई आधिकारिक गति संख्या नहीं है। बच्चे की प्रगति की तुलना स्वयं के पिछले मूल्यांकन से होती है।"
        }
    }
}

with open('assets/curriculum/benchmarks.json', 'w', encoding='utf-8') as f:
    json.dump(benchmarks, f, indent=2, ensure_ascii=False)

# 3. assets/curriculum/registry.json
curriculum_registry = {
    "version": "1.0",
    "curricula": [
        {
            "id": "ncert_cbse",
            "name_en": "NCERT / CBSE",
            "name_hi": "एनसीईआरटी / सीबीएसई",
            "description_en": "National curriculum aligned with NCF-FS 2022 and NCF-SE 2023.",
            "description_hi": "राष्ट्रीय पाठ्यचर्या रूपरेखा 2022 और 2023 के अनुरूप।",
            "languages": ["hi", "en"],
            "verification_status": "verified"
        },
        {
            "id": "up",
            "name_en": "Uttar Pradesh Basic Shiksha",
            "name_hi": "उत्तर प्रदेश बेसिक शिक्षा परिषद",
            "description_en": "UP SCERT curriculum and NIPUN UP tables.",
            "description_hi": "उत्तर प्रदेश बेसिक शिक्षा विभाग निपुण तालिका आधारित।",
            "languages": ["hi"],
            "verification_status": "partially_verified",
            "verification_note": "Class 3 Veena verified; Classes 1, 2, 4, 5 textbook titles are unverified pending UP SCERT portal access."
        },
        {
            "id": "rajasthan",
            "name_en": "Rajasthan RSCERT",
            "name_hi": "राजस्थान आरएससीईआरटी उदयपुर",
            "description_en": "RSCERT Udaipur curriculum and Hindi teacher guides (2025).",
            "description_hi": "आरएससीईआरटी उदयपुर द्वारा निर्धारित पाठ्यपुस्तकें और शिक्षक संदर्शिका।",
            "languages": ["hi"],
            "verification_status": "verified"
        },
        {
            "id": "school_own",
            "name_en": "School's Own Curriculum",
            "name_hi": "विद्यालय का अपना पाठ्यक्रम",
            "description_en": "For independent, state, or private schools following custom materials.",
            "description_hi": "निजी या अन्य विद्यालयों के लिए जो स्वयं की पाठ्य सामग्री अपनाते हैं।",
            "languages": ["hi", "en", "mr"],
            "verification_status": "custom"
        }
    ],
    "textbooks": [
        {
            "curriculum_id": "ncert_cbse",
            "grade": 1,
            "subject": "hindi",
            "title": "सारंगी (भाग-1)",
            "publisher": "NCERT (2024-25)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "मीना का परिवार", "page": 1},
                {"number": 2, "title": "दादा-दादी", "page": 7},
                {"number": 3, "title": "रीना का दिन", "page": 13},
                {"number": 4, "title": "रानी भी", "page": 19},
                {"number": 5, "title": "मिठाई", "page": 24}
            ]
        },
        {
            "curriculum_id": "ncert_cbse",
            "grade": 2,
            "subject": "hindi",
            "title": "सारंगी (भाग-2)",
            "publisher": "NCERT (2024-25)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "नीमा की दादी", "page": 1},
                {"number": 2, "title": "घर", "page": 8},
                {"number": 3, "title": "माला की चाँदी की पायल", "page": 15},
                {"number": 4, "title": "मांगू का जूता", "page": 22},
                {"number": 5, "title": "टिल्लू जी", "page": 29}
            ]
        },
        {
            "curriculum_id": "ncert_cbse",
            "grade": 3,
            "subject": "hindi",
            "title": "वीणा (भाग-1)",
            "publisher": "NCERT (2024-25)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "चित्र और बातचीत: मेला", "page": 2},
                {"number": 2, "title": "सीखो", "page": 8},
                {"number": 3, "title": "चींटी", "page": 14},
                {"number": 4, "title": "समय का मोल", "page": 20},
                {"number": 5, "title": "बहादुर बित्तो", "page": 28}
            ]
        },
        {
            "curriculum_id": "ncert_cbse",
            "grade": 4,
            "subject": "hindi",
            "title": "वीणा (भाग-2)",
            "publisher": "NCERT (2024-25)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "मन के भोले-भाले बादल", "page": 1},
                {"number": 2, "title": "जैसा सवाल वैसा जवाब", "page": 6},
                {"number": 3, "title": "किरमिच की गेंद", "page": 12},
                {"number": 4, "title": "पापा जब बच्चे थे", "page": 20}
            ]
        },
        {
            "curriculum_id": "ncert_cbse",
            "grade": 5,
            "subject": "hindi",
            "title": "वीणा (भाग-3)",
            "publisher": "NCERT (2024-25)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "राख की रस्सी", "page": 1},
                {"number": 2, "title": "फसलों के त्योहार", "page": 7},
                {"number": 3, "title": "खिलौनेवाला", "page": 15},
                {"number": 4, "title": "नन्हा फनकार", "page": 22}
            ]
        },
        {
            "curriculum_id": "up",
            "grade": 3,
            "subject": "hindi",
            "title": "वीणा (भाग-1, उप्र संस्करण)",
            "publisher": "बेसिक शिक्षा परिषद उप्र (2025-26)",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "प्रार्थना", "page": 1},
                {"number": 2, "title": "मुर्गा और लोमड़ी", "page": 5},
                {"number": 3, "title": "गिलहरी का घर", "page": 11}
            ]
        },
        {
            "curriculum_id": "rajasthan",
            "grade": 1,
            "subject": "hindi",
            "title": "नन्हे कदम भाग-1",
            "publisher": "RSCERT उदयपुर",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "मेरा घर", "page": 1},
                {"number": 2, "title": "पतंग", "page": 8},
                {"number": 3, "title": "मेले की सैर", "page": 14}
            ]
        },
        {
            "curriculum_id": "rajasthan",
            "grade": 2,
            "subject": "hindi",
            "title": "नन्हे कदम भाग-2",
            "publisher": "RSCERT उदयपुर",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "सूरज आया", "page": 1},
                {"number": 2, "title": "भालू ने खेली फुटबॉल", "page": 7},
                {"number": 3, "title": "म्याऊं म्याऊं", "page": 13}
            ]
        },
        {
            "curriculum_id": "rajasthan",
            "grade": 3,
            "subject": "hindi",
            "title": "हिंदी सुमन भाग-1",
            "publisher": "RSCERT उदयपुर",
            "verification": "verified",
            "chapters": [
                {"number": 1, "title": "देश हमारा", "page": 1},
                {"number": 2, "title": "मीठे बोल", "page": 6},
                {"number": 3, "title": "गिलहरी", "page": 12}
            ]
        }
    ],
    "learning_outcomes": [
        {"code": "H101", "grade": 1, "skill": "listening", "description_hi": "बातचीत में ध्यानपूर्वक सुनते हैं और अपनी प्रतिक्रिया देते हैं।"},
        {"code": "H102", "grade": 1, "skill": "decoding", "description_hi": "सरल वर्णों और बिना मात्रा वाले 2-3 अक्षरी शब्दों को पहचानते हैं।"},
        {"code": "H103", "grade": 1, "skill": "reading", "description_hi": "4-5 सरल शब्दों के छोटे वाक्यों को पढ़ते हैं।"},
        {"code": "H104", "grade": 1, "skill": "writing", "description_hi": "सुने हुए परिचित शब्दों को लिखते हैं (श्रुतलेख)।"},
        {"code": "H201", "grade": 2, "skill": "decoding", "description_hi": "आ, इ, ई, उ, ऊ आदि मुख्य मात्राओं से बने शब्दों को पहचानते हैं।"},
        {"code": "H206", "grade": 2, "skill": "fluency", "description_hi": "45 से 60 शब्द प्रति मिनट की गति से प्रवाहपूर्ण पढ़ते हैं।"},
        {"code": "H208", "grade": 2, "skill": "comprehension", "description_hi": "पढ़ी गई छोटी कहानी के मुख्य पात्र और घटनाओं को बताते हैं।"},
        {"code": "H210", "grade": 2, "skill": "writing", "description_hi": "मात्रा वाले 5 परिचित शब्दों का सही श्रुतलेख लिखते हैं।"},
        {"code": "H301", "grade": 3, "skill": "decoding", "description_hi": "संयुक्त अक्षरों (क्य, प्र, स्त आदि) और अनुस्वार-चंद्रबिंदु युक्त शब्दों को सही पढ़ते हैं।"},
        {"code": "H306", "grade": 3, "skill": "fluency", "description_hi": "कम से कम 60 शब्द प्रति मिनट की गति से सही उच्चारण के साथ पढ़ते हैं।"},
        {"code": "H308", "grade": 3, "skill": "comprehension", "description_hi": "कहानी पढ़कर 4 में से कम से कम 3 प्रश्नों (तथ्य, शब्द अर्थ, कारण-प्रभाव) का सही उत्तर देते हैं।"},
        {"code": "H312", "grade": 3, "skill": "writing", "description_hi": "सयुंक्ताक्षर और मात्राओं वाले 5 शब्दों का श्रुतलेख सही लिखते हैं।"},
        {"code": "H401", "grade": 4, "skill": "reading", "description_hi": "विविध प्रकार के गद्यांश को उचित आरोह-अवरोह के साथ पढ़ते हैं।"},
        {"code": "H405", "grade": 4, "skill": "comprehension", "description_hi": "पाठ में आए नए शब्दों के अर्थ संदर्भ से समझते हैं।"},
        {"code": "H501", "grade": 5, "skill": "reading", "description_hi": "कक्षा स्तर के अपठित गद्यांश को धाराप्रवाह और समझ के साथ पढ़ते हैं।"},
        {"code": "H506", "grade": 5, "skill": "critical_thinking", "description_hi": "पाठ की घटनाओं और पात्रों के व्यवहार पर अपनी राय व्यक्त करते हैं।"}
    ]
}

with open('assets/curriculum/registry.json', 'w', encoding='utf-8') as f:
    json.dump(curriculum_registry, f, indent=2, ensure_ascii=False)

# 4. assets/passages/bank.json
# Bundles original passages across all 5 classes (at least 2 per class)
passage_bank = {
    "version": "1.0",
    "review_status": "pending_teacher_review",
    "note": "Original passages aligned with NIPUN, NCERT and state learning milestones.",
    "passages": [
        # Grade 1 - Passage 1 (Word List / Simple Sentences)
        {
            "id": "p_g1_01",
            "grade": 1,
            "curriculum": "all",
            "type": "sentences",
            "title_hi": "अमन और आम",
            "title_en": "Aman and Mango",
            "text_hi": "अमन घर चल। आम चख। नल पर जल भर। छत पर मत चढ़। बस पर चढ़ कर चल।",
            "text_en": "Aman go home. Taste the mango. Fill water at the tap. Do not climb on the roof. Get on the bus and go.",
            "word_count": 18,
            "difficulty_level": "easy",
            "outcome_codes": ["H102", "H103"],
            "skills": ["basic_decoding", "sentence_reading"],
            "retell_points": [
                "अमन को घर चलने को कहा गया",
                "अमन को आम चखने को कहा",
                "नल पर पानी भरने की बात",
                "बस पर चढ़कर जाने को कहा"
            ],
            "retell_points_en": [
                "Aman was asked to go home",
                "Aman was asked to taste the mango",
                "Talk of filling water at the tap",
                "Asked to take the bus and go"
            ],
            "questions": [
                {
                    "id": "q_g1_01_1",
                    "type": "fact",
                    "question_hi": "अमन को क्या चखने को कहा गया?",
                    "question_en": "What was Aman asked to taste?",
                    "expected_answer_hi": "आम",
                    "expected_answer_en": "Mango",
                    "points": 1
                },
                {
                    "id": "q_g1_01_2",
                    "type": "fact",
                    "question_hi": "जल कहाँ भरना है?",
                    "question_en": "Where to fill water?",
                    "expected_answer_hi": "नल पर",
                    "expected_answer_en": "At the tap",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["अमन", "घर", "आम", "जल", "बस"],
            "dictation_fallback_words_en": ["Aman", "home", "mango", "water", "bus"],
            "review_status": "pending_teacher_review"
        },
        # Grade 1 - Passage 2
        {
            "id": "p_g1_02",
            "grade": 1,
            "curriculum": "all",
            "type": "sentences",
            "title_hi": "मीना की गुड़िया",
            "title_en": "Meena's Doll",
            "text_hi": "मीना की एक गुड़िया है। गुड़िया लाल फ्रॉक पहनती है। मीना उसे रोज नहलाती है। वह बहुत खुश रहती है।",
            "text_en": "Meena has a doll. The doll wears a red frock. Meena bathes her every day. She stays very happy.",
            "word_count": 19,
            "difficulty_level": "easy",
            "outcome_codes": ["H102", "H103"],
            "skills": ["matra_decoding", "short_sentences"],
            "retell_points": [
                "मीना के पास एक गुड़िया है",
                "गुड़िया लाल रंग की फ्रॉक पहनती है",
                "मीना गुड़िया को रोज नहलाती है",
                "गुड़िया खुश रहती है"
            ],
            "retell_points_en": [
                "Meena has a doll",
                "The doll wears a red frock",
                "Meena bathes the doll daily",
                "The doll stays happy"
            ],
            "questions": [
                {
                    "id": "q_g1_02_1",
                    "type": "fact",
                    "question_hi": "मीना के पास क्या है?",
                    "question_en": "What does Meena have?",
                    "expected_answer_hi": "गुड़िया",
                    "expected_answer_en": "Doll",
                    "points": 1
                },
                {
                    "id": "q_g1_02_2",
                    "type": "fact",
                    "question_hi": "गुड़िया का फ्रॉक किस रंग का है?",
                    "question_en": "What color is the doll's frock?",
                    "expected_answer_hi": "लाल",
                    "expected_answer_en": "Red",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["मीना", "गुड़िया", "लाल", "रोज", "खुश"],
            "dictation_fallback_words_en": ["Meena", "doll", "red", "daily", "happy"],
            "review_status": "pending_teacher_review"
        },
        # Grade 2 - Passage 1
        {
            "id": "p_g2_01",
            "grade": 2,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "प्यासा कौआ और मटका",
            "title_en": "The Thirsty Crow",
            "text_hi": "एक कौआ बहुत प्यासा था। वह पानी की तलाश में इधर-उधर उड़ रहा था। उसने एक बगीचे में घड़ा देखा। घड़े में पानी बहुत नीचे था। कौवे की चोंच पानी तक नहीं पहुँच सकी। उसने पास पड़े छोटे कंकड़ उठाए और घड़े में डाले। पानी ऊपर आ गया। कौवे ने पानी पिया और उड़ गया।",
            "text_en": "A crow was very thirsty. He was flying here and there in search of water. He saw a pitcher in a garden. The water was very low in the pitcher. The crow's beak could not reach the water. He picked up small pebbles lying nearby and dropped them into the pitcher. The water rose up. The crow drank the water and flew away.",
            "word_count": 54,
            "difficulty_level": "medium",
            "outcome_codes": ["H201", "H206", "H208"],
            "skills": ["matra_fluency", "cause_effect"],
            "retell_points": [
                "कौआ बहुत प्यासा था और पानी खोज रहा था",
                "उसने बगीचे में घड़ा देखा",
                "घड़े में पानी बहुत कम और नीचे था",
                "चोंच नहीं पहुँची तो उसने कंकड़ डाले",
                "पानी ऊपर आ गया और कौवे ने पिया"
            ],
            "retell_points_en": [
                "The crow was very thirsty and searched for water",
                "He spotted a pitcher in a garden",
                "The water in the pitcher was very low",
                "His beak could not reach so he dropped pebbles",
                "The water rose up and the crow drank it"
            ],
            "questions": [
                {
                    "id": "q_g2_01_1",
                    "type": "fact",
                    "question_hi": "कौआ बगीचे में क्या ढूंढ रहा था?",
                    "question_en": "What was the crow searching for in the garden?",
                    "expected_answer_hi": "पानी",
                    "expected_answer_en": "Water",
                    "points": 1
                },
                {
                    "id": "q_g2_01_2",
                    "type": "why_how",
                    "question_hi": "कौवे ने घड़े में कंकड़ क्यों डाले?",
                    "question_en": "Why did the crow put pebbles in the pitcher?",
                    "expected_answer_hi": "पानी ऊपर लाने के लिए",
                    "expected_answer_en": "To bring the water up",
                    "points": 1
                },
                {
                    "id": "q_g2_01_3",
                    "type": "main_idea",
                    "question_hi": "इस कहानी से हमें क्या सीख मिलती है?",
                    "question_en": "What do we learn from this story?",
                    "expected_answer_hi": "मेहनत और समझदारी से काम बनता है",
                    "expected_answer_en": "Hard work and clever thinking bring success",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["प्यासा", "घड़ा", "चोंच", "कंकड़", "बगीचा"],
            "dictation_fallback_words_en": ["thirsty", "pitcher", "beak", "pebbles", "garden"],
            "review_status": "pending_teacher_review"
        },
        # Grade 2 - Passage 2
        {
            "id": "p_g2_02",
            "grade": 2,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "भालू की गेंद",
            "title_en": "Bear's Ball",
            "text_hi": "सर्दियों का मौसम था। सुबह का समय था और चारों तरफ कोहरा ही कोहरा था। एक शेर का बच्चा सिमटकर गोल-मटोल बना जामुन के पेड़ के नीचे सोया था। भालू साहब सैर पर निकले। उनकी नज़र जामुन के पेड़ पर पड़ी। उन्होंने देखा फुटबॉल! आव देखा न ताव, भालू जी ने पैर से उछाल दिया।",
            "text_en": "It was winter season. It was morning and there was fog all around. A lion cub was curled up asleep like a round ball under a jamun tree. Mr. Bear went out for a stroll. His eyes fell on the jamun tree. He saw a football! Without a second thought, Bear kicked it high into the air.",
            "word_count": 52,
            "difficulty_level": "medium",
            "outcome_codes": ["H201", "H206", "H208"],
            "skills": ["story_reading", "recall"],
            "retell_points": [
                "सर्दियों का मौसम और सुबह का समय था",
                "शेर का बच्चा जामुन के पेड़ के नीचे सोया था",
                "भालू सैर पर निकला और उसकी नज़र पड़ी",
                "भालू ने शेर के बच्चे को फुटबॉल समझकर लात मार दी"
            ],
            "retell_points_en": [
                "It was a cold winter morning",
                "A lion cub was sleeping under a tree",
                "Bear went for a walk and saw the cub",
                "Bear thought the cub was a football and kicked it"
            ],
            "questions": [
                {
                    "id": "q_g2_02_1",
                    "type": "fact",
                    "question_hi": "मौसम कैसा था?",
                    "question_en": "What was the weather like?",
                    "expected_answer_hi": "सर्दियों का मौसम / ठंड",
                    "expected_answer_en": "Winter season / cold",
                    "points": 1
                },
                {
                    "id": "q_g2_02_2",
                    "type": "why_how",
                    "question_hi": "भालू ने शेर के बच्चे को क्यों उछाला?",
                    "question_en": "Why did the bear kick the lion cub?",
                    "expected_answer_hi": "फुटबॉल समझकर",
                    "expected_answer_en": "Thinking it was a football",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["सर्दियों", "मौसम", "कोहरा", "फुटबॉल", "जामुन"],
            "dictation_fallback_words_en": ["winter", "season", "fog", "football", "tree"],
            "review_status": "pending_teacher_review"
        },
        # Grade 3 - Passage 1 (Standard benchmark passage ~65 words)
        {
            "id": "p_g3_01",
            "grade": 3,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "सूरज और हवा की शर्त",
            "title_en": "Sun and Wind",
            "text_hi": "एक बार सूरज और हवा में बहस छिड़ गई। हवा ने कहा, 'मैं तुमसे अधिक बलवान हूँ।' सूरज ने मुस्कुराकर कहा, 'देखते हैं।' तभी रास्ते में एक आदमी कोट पहनकर जा रहा था। हवा ने कहा, 'जो इस आदमी का कोट उतरवा देगा, वही जीतेगा।' हवा तेज़ बहने लगी। आदमी ने कोट कसकर पकड़ लिया। अब सूरज तपने लगा। गर्मी बढ़ी तो आदमी ने कोट उतार दिया। हवा ने हार मान ली।",
            "text_en": "Once an argument broke out between the sun and the wind. The wind said, 'I am stronger than you.' The sun smiled and said, 'Let us see.' Just then a man wearing a coat was walking on the road. The wind said, 'Whoever makes this man take off his coat shall win.' The wind blew hard. The man wrapped his coat tightly. Then the sun shone bright. As heat increased, the man took off his coat. The wind accepted defeat.",
            "word_count": 68,
            "difficulty_level": "standard",
            "outcome_codes": ["H301", "H306", "H308"],
            "skills": ["conjuncts", "fluency_60wpm", "comprehension_4q"],
            "retell_points": [
                "सूरज और हवा में बलवान होने पर बहस हुई",
                "रास्ते में एक आदमी कोट पहनकर जा रहा था",
                "कोट उतरवाने की शर्त रखी गई",
                "हवा तेज़ चली तो आदमी ने कोट कस लिया",
                "सूरज तपा तो गर्मी से आदमी ने कोट उतार दिया",
                "हवा ने अपनी हार मान ली"
            ],
            "retell_points_en": [
                "Sun and wind argued about who was stronger",
                "A man wearing a coat was walking on the road",
                "A challenge was set to remove the coat",
                "Wind blew hard so the man held the coat tight",
                "Sun shone bright and the man removed his coat",
                "Wind accepted defeat"
            ],
            "questions": [
                {
                    "id": "q_g3_01_1",
                    "type": "fact",
                    "question_hi": "सूरज और हवा के बीच किस बात पर बहस हुई?",
                    "question_en": "What did the sun and wind argue about?",
                    "expected_answer_hi": "अधिक बलवान होने पर",
                    "expected_answer_en": "About who was stronger",
                    "points": 1
                },
                {
                    "id": "q_g3_01_2",
                    "type": "word_meaning",
                    "question_hi": "'बलवान' शब्द का क्या अर्थ है?",
                    "question_en": "What does the word 'stronger' mean?",
                    "expected_answer_hi": "ताकतवर / शक्तिशाली",
                    "expected_answer_en": "Having great power or strength / powerful",
                    "points": 1
                },
                {
                    "id": "q_g3_01_3",
                    "type": "why_how",
                    "question_hi": "आदमी ने अपना कोट क्यों उतार दिया?",
                    "question_en": "Why did the man take off his coat?",
                    "expected_answer_hi": "सूरज के तपने से बहुत गर्मी लगी",
                    "expected_answer_en": "Because of the heat from the shining sun",
                    "points": 1
                },
                {
                    "id": "q_g3_01_4",
                    "type": "main_idea",
                    "question_hi": "इस कहानी का मुख्य संदेश क्या है?",
                    "question_en": "What is the main message of this story?",
                    "expected_answer_hi": "घमंड करने से नुकसान होता है / नम्रता और युक्ति से काम बनता है",
                    "expected_answer_en": "Pride harms, while gentleness and wisdom win",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["बलवान", "मुस्कुराकर", "शर्त", "रास्ता", "अधिक"],
            "dictation_fallback_words_en": ["strong", "smiled", "challenge", "road", "greater"],
            "review_status": "pending_teacher_review"
        },
        # Grade 3 - Passage 2
        {
            "id": "p_g3_02",
            "grade": 3,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "चींटी और कबूतर",
            "title_en": "The Ant and the Dove",
            "text_hi": "एक छोटी चींटी नदी के किनारे पानी पी रही थी। अचानक उसका पैर फिसला और वह पानी की तेज धारा में बहने लगी। पेड़ की डाल पर बैठा कबूतर यह सब देख रहा था। उसने तुरंत एक सूखा पत्ता तोड़ा और चींटी के पास गिरा दिया। चींटी पत्ते पर चढ़ गई और किनारे आ गई। कुछ दिनों बाद एक शिकारी जाल लेकर आया। चींटी ने शिकारी के पैर पर ज़ोर से काटा। शिकारी चिल्लाया और कबूतर उड़ गया।",
            "text_en": "A little ant was drinking water by the river bank. Suddenly her foot slipped and she was swept away in the rapid current. A dove sitting on a branch saw this happen. He promptly plucked a dry leaf and dropped it near the ant. The ant climbed onto the leaf and reached the bank safely. A few days later a hunter arrived with a net. The ant bit the hunter's foot hard. The hunter cried out and the dove flew away safely.",
            "word_count": 74,
            "difficulty_level": "standard",
            "outcome_codes": ["H301", "H306", "H308"],
            "skills": ["fluency_60wpm", "inference", "questions_4"],
            "retell_points": [
                "चींटी नदी में पानी पीते समय फिसल गई",
                "कबूतर ने पत्ता गिराकर चींटी की जान बचाई",
                "कुछ दिन बाद जंगल में शिकारी आया",
                "चींटी ने शिकारी के पैर पर काटा",
                "शिकारी चिल्लाया और कबूतर सुरक्षित उड़ गया"
            ],
            "retell_points_en": [
                "The ant slipped while drinking water from the river",
                "The dove dropped a leaf to save the ant's life",
                "A few days later a hunter arrived in the woods",
                "The ant bit the hunter on his foot",
                "The hunter yelled and the dove flew to safety"
            ],
            "questions": [
                {
                    "id": "q_g3_02_1",
                    "type": "fact",
                    "question_hi": "कबूतर ने चींटी को बचाने के लिए क्या किया?",
                    "question_en": "What did the dove do to save the ant?",
                    "expected_answer_hi": "पानी में पत्ता गिराया",
                    "expected_answer_en": "Dropped a leaf into the water",
                    "points": 1
                },
                {
                    "id": "q_g3_02_2",
                    "type": "word_meaning",
                    "question_hi": "'तुरंत' का क्या अर्थ होता है?",
                    "question_en": "What does the word 'promptly' mean?",
                    "expected_answer_hi": "जल्दी से / उसी समय",
                    "expected_answer_en": "Quickly / right away",
                    "points": 1
                },
                {
                    "id": "q_g3_02_3",
                    "type": "why_how",
                    "question_hi": "चींटी ने शिकारी को क्यों काटा?",
                    "question_en": "Why did the ant bite the hunter?",
                    "expected_answer_hi": "कबूतर को शिकारी से बचाने के लिए",
                    "expected_answer_en": "To protect the dove from the hunter",
                    "points": 1
                },
                {
                    "id": "q_g3_02_4",
                    "type": "main_idea",
                    "question_hi": "इस कहानी से हमें क्या शिक्षा मिलती है?",
                    "question_en": "What lesson do we learn from this story?",
                    "expected_answer_hi": "कर भला तो हो भला / दूसरों की मदद करनी चाहिए",
                    "expected_answer_en": "One good turn deserves another / always help each other",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["फिसला", "कबूतर", "शिकारी", "तुरंत", "किनारे"],
            "dictation_fallback_words_en": ["slipped", "dove", "hunter", "promptly", "bank"],
            "review_status": "pending_teacher_review"
        },
        # Grade 4 - Passage 1
        {
            "id": "p_g4_01",
            "grade": 4,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "जंगल की पाठशाला",
            "title_en": "Forest School",
            "text_hi": "बरगद के घने पेड़ के नीचे जंगल के सभी नन्हे जानवर इकट्ठा होते थे। उल्लू दादा चश्मा लगाकर उन्हें ज्ञान की बातें सिखाते थे। खरगोश चंचलता छोड़कर शांत बैठना सीखता, तो गिलहरी अखरोट तोड़ने की सही कला सीखती। एक दिन जंगल में तेज़ आंधी आई। उल्लू दादा की सीख याद करके सभी जानवरों ने गुफा में शरण ली और सुरक्षित रहे। एकता और ज्ञान ने सबकी रक्षा की।",
            "text_en": "Under the dense banyan tree, all the little forest animals gathered together. Grandpa Owl wore spectacles and taught them words of wisdom. The rabbit learned to sit quietly instead of hopping, while the squirrel learned the art of cracking walnuts. One day a fierce storm hit the forest. Remembering Grandpa Owl's advice, all animals took shelter in a cave and remained safe. Unity and wisdom protected everyone.",
            "word_count": 68,
            "difficulty_level": "advanced",
            "outcome_codes": ["H401", "H405"],
            "skills": ["complex_conjuncts", "vocabulary", "inference"],
            "retell_points": [
                "बरगद के नीचे नन्हे जानवर पढ़ते थे",
                "उल्लू दादा चश्मा लगाकर सिखाते थे",
                "खरगोश और गिलहरी अच्छी आदतें सीखते थे",
                "तेज़ आंधी आने पर सब गुफा में गए",
                "एकता और सीख से सब सुरक्षित रहे"
            ],
            "retell_points_en": [
                "Little animals studied under the banyan tree",
                "Grandpa Owl taught them wearing glasses",
                "Rabbit and squirrel learned good habits",
                "During a fierce storm they all went into a cave",
                "Unity and wisdom kept everyone safe"
            ],
            "questions": [
                {
                    "id": "q_g4_01_1",
                    "type": "fact",
                    "question_hi": "जानवरों के शिक्षक कौन थे?",
                    "question_en": "Who was the teacher of the animals?",
                    "expected_answer_hi": "उल्लू दादा",
                    "expected_answer_en": "Grandpa Owl",
                    "points": 1
                },
                {
                    "id": "q_g4_01_2",
                    "type": "word_meaning",
                    "question_hi": "'शरण' शब्द का क्या अर्थ है?",
                    "question_en": "What does the word 'shelter' mean?",
                    "expected_answer_hi": "आश्रय / ओट / सुरक्षित जगह",
                    "expected_answer_en": "A safe place / refuge",
                    "points": 1
                },
                {
                    "id": "q_g4_01_3",
                    "type": "why_how",
                    "question_hi": "आंधी आने पर जानवरों ने क्या किया?",
                    "question_en": "What did the animals do when the storm came?",
                    "expected_answer_hi": "गुफा में जाकर शरण ली",
                    "expected_answer_en": "Took shelter inside a cave",
                    "points": 1
                },
                {
                    "id": "q_g4_01_4",
                    "type": "main_idea",
                    "question_hi": "इस पाठ का मुख्य भाव क्या है?",
                    "question_en": "What is the central theme of this lesson?",
                    "expected_answer_hi": "ज्ञान और एकता से विपत्ति से बचा जा सकता है",
                    "expected_answer_en": "Wisdom and unity help overcome adversity",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["इकट्ठा", "चंचलता", "अखरोट", "सुरक्षित", "विपत्ति"],
            "dictation_fallback_words_en": ["gathered", "restless", "walnut", "shelter", "wisdom"],
            "review_status": "pending_teacher_review"
        },
        # Grade 4 - Passage 2
        {
            "id": "p_g4_02",
            "grade": 4,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "जल ही जीवन है",
            "title_en": "Water is Life",
            "text_hi": "पानी हमारे जीवन की सबसे अनमोल निधि है। सुबह उठने से लेकर रात को सोने तक हमें पानी की आवश्यकता होती है। किसान खेतों में फसल उगाने के लिए पानी पर निर्भर रहते हैं। यदि जल स्रोत प्रदूषित हो जाएं, तो बीमारियाँ फैलती हैं। इसलिए हमें पानी की एक-एक बूँद बचानी चाहिए और नलों को खुला नहीं छोड़ना चाहिए।",
            "text_en": "Water is the most precious gift of our lives. From waking up in the morning to sleeping at night, we need water for everything. Farmers rely on water to cultivate crops in their fields. If water sources become polluted, diseases spread rapidly. Therefore, we must save every single drop of water and never leave taps running open.",
            "word_count": 59,
            "difficulty_level": "advanced",
            "outcome_codes": ["H401", "H405"],
            "skills": ["informative_text", "cause_effect"],
            "retell_points": [
                "पानी अनमोल निधि है",
                "सुबह से रात तक पानी की जरूरत होती है",
                "खेतों में फसल उगाने के लिए पानी चाहिए",
                "प्रदूषण से बीमारियाँ फैलती हैं",
                "पानी की हर बूँद बचानी चाहिए"
            ],
            "retell_points_en": [
                "Water is a precious resource",
                "Water is needed throughout the entire day",
                "Farmers depend on water to cultivate crops",
                "Water pollution leads to disease",
                "Every single drop of water must be preserved"
            ],
            "questions": [
                {
                    "id": "q_g4_02_1",
                    "type": "fact",
                    "question_hi": "किसान पानी का उपयोग किस काम में करते हैं?",
                    "question_en": "How do farmers use water?",
                    "expected_answer_hi": "फसल उगाने के लिए / खेती में",
                    "expected_answer_en": "To cultivate crops / for farming",
                    "points": 1
                },
                {
                    "id": "q_g4_02_2",
                    "type": "why_how",
                    "question_hi": "पानी का संरक्षण क्यों आवश्यक है?",
                    "question_en": "Why is water conservation necessary?",
                    "expected_answer_hi": "क्योंकि जल जीवन के लिए अनमोल है और इसके बिना जीवन संभव नहीं",
                    "expected_answer_en": "Because water is precious and life is impossible without it",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["अनमोल", "आवश्यकता", "प्रदूषित", "स्रोत", "संरक्षण"],
            "dictation_fallback_words_en": ["precious", "requirement", "polluted", "source", "conservation"],
            "review_status": "pending_teacher_review"
        },
        # Grade 5 - Passage 1
        {
            "id": "p_g5_01",
            "grade": 5,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "पुस्तकालय का जादू",
            "title_en": "The Magic of Library",
            "text_hi": "गाँव के पुराने विद्यालय में एक छोटा सा पुस्तकालय स्थापित हुआ। पहले दिन बच्चे केवल रंगीन चित्रों वाली कहानियाँ देख रहे थे। धीरे-धीरे उन्होंने विज्ञान, इतिहास और महापुरुषों की जीवनियाँ पढ़ना शुरू किया। रोहन को अंतरिक्ष से जुड़ी पुस्तकों में विशेष रुचि थी। उसने तारों और ग्रहों के रहस्य जाने। पुस्तकें हमें घर बैठे पूरी दुनिया की सैर कराती हैं और हमारे दृष्टिकोण को विशाल बनाती हैं।",
            "text_en": "A small library was set up in the old village school. On the first day, children only looked at stories with colorful pictures. Gradually, they began reading science, history, and biographies of great leaders. Rohan had a special interest in books about outer space. He learned secrets of the stars and planets. Books let us travel the world from home and broaden our horizons.",
            "word_count": 68,
            "difficulty_level": "grade5",
            "outcome_codes": ["H501", "H506"],
            "skills": ["critical_reading", "vocabulary", "broad_comprehension"],
            "retell_points": [
                "गाँव के स्कूल में नया पुस्तकालय खुला",
                "बच्चों ने चित्रों वाली कहानियों से शुरुआत की",
                "बाद में विज्ञान और इतिहास की पुस्तकें पढ़ीं",
                "रोहन को अंतरिक्ष में विशेष रुचि थी",
                "पुस्तकें दृष्टिकोण विशाल बनाती हैं"
            ],
            "retell_points_en": [
                "A library was set up in the village school",
                "Children started with picture stories",
                "Later they read science, history and biographies",
                "Rohan was fascinated by books on outer space",
                "Books broaden our vision and perspectives"
            ],
            "questions": [
                {
                    "id": "q_g5_01_1",
                    "type": "fact",
                    "question_hi": "रोहन को किस विषय की पुस्तकों में विशेष रुचि थी?",
                    "question_en": "Which topic of books was Rohan especially interested in?",
                    "expected_answer_hi": "अंतरिक्ष और तारों-ग्रहों के विषय में",
                    "expected_answer_en": "Outer space, stars, and planets",
                    "points": 1
                },
                {
                    "id": "q_g5_01_2",
                    "type": "word_meaning",
                    "question_hi": "'दृष्टिकोण' का क्या अर्थ है?",
                    "question_en": "What does the word 'horizons' mean in this context?",
                    "expected_answer_hi": "सोचने का नजरिया / देखने का ढंग",
                    "expected_answer_en": "Perspective / point of view / range of thinking",
                    "points": 1
                },
                {
                    "id": "q_g5_01_3",
                    "type": "why_how",
                    "question_hi": "पुस्तकों को दुनिया की सैर कराने वाला क्यों कहा गया है?",
                    "question_en": "Why are books said to take us on a tour of the world?",
                    "expected_answer_hi": "क्योंकि वे हमें घर बैठे दूर देशों और ज्ञान की जानकारी देती हैं",
                    "expected_answer_en": "Because they give us knowledge of faraway lands from home",
                    "points": 1
                },
                {
                    "id": "q_g5_01_4",
                    "type": "main_idea",
                    "question_hi": "इस पाठ का मुख्य विचार क्या है?",
                    "question_en": "What is the central idea?",
                    "expected_answer_hi": "पुस्तकालय और पुस्तकों का हमारे ज्ञान व सोच पर गहरा प्रभाव पड़ता है",
                    "expected_answer_en": "Libraries and reading deeply expand our knowledge and thinking",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["पुस्तकालय", "अंतरिक्ष", "दृष्टिकोण", "महापुरुषों", "रहस्य"],
            "dictation_fallback_words_en": ["library", "space", "perspective", "leaders", "secrets"],
            "review_status": "pending_teacher_review"
        },
        # Grade 5 - Passage 2
        {
            "id": "p_g5_02",
            "grade": 5,
            "curriculum": "all",
            "type": "passage",
            "title_hi": "समय का सदुपयोग",
            "title_en": "Right Use of Time",
            "text_hi": "समय निरंतर बहती नदी की तरह है, जो कभी वापस नहीं लौटती। जो व्यक्ति समय का मूल्य समझता है, सफलता उसी के कदम चूमती है। विद्यार्थी जीवन में समय का अनुशासन सबसे महत्वपूर्ण गुण है। आज का काम कल पर टालने की आदत असफलता की ओर ले जाती है। प्रत्येक क्षण को उपयोगी बनाकर ही हम अपने सपनों को साकार कर सकते हैं।",
            "text_en": "Time is like a continuous flowing river that never turns back. Success kisses the feet of one who understands the value of time. In student life, discipline of time is the most essential quality. The habit of postponing today's task until tomorrow leads toward failure. Only by making purposeful use of every single moment can we turn our dreams into reality.",
            "word_count": 63,
            "difficulty_level": "grade5",
            "outcome_codes": ["H501", "H506"],
            "skills": ["reflective_reading", "idioms", "values"],
            "retell_points": [
                "समय निरंतर बहती नदी के समान है",
                "समय का मूल्य समझने वाले को सफलता मिलती है",
                "विद्यार्थी जीवन में अनुशासन जरूरी है",
                "काम टालने की आदत से असफलता मिलती है",
                "हर क्षण का सदुपयोग करके सपने साकार होते हैं"
            ],
            "retell_points_en": [
                "Time is like a constantly flowing river",
                "Those who value time achieve success",
                "Discipline is vital in student life",
                "Postponing work leads to failure",
                "Valuing every moment turns dreams into reality"
            ],
            "questions": [
                {
                    "id": "q_g5_02_1",
                    "type": "fact",
                    "question_hi": "समय की तुलना किससे की गई है?",
                    "question_en": "What is time compared to?",
                    "expected_answer_hi": "निरंतर बहती नदी से",
                    "expected_answer_en": "A constantly flowing river",
                    "points": 1
                },
                {
                    "id": "q_g5_02_2",
                    "type": "word_meaning",
                    "question_hi": "'सदुपयोग' का क्या अर्थ है?",
                    "question_en": "What does 'purposeful use' mean?",
                    "expected_answer_hi": "सही या अच्छा उपयोग",
                    "expected_answer_en": "Good or productive use",
                    "points": 1
                },
                {
                    "id": "q_g5_02_3",
                    "type": "why_how",
                    "question_hi": "विद्यार्थी के लिए काम को कल पर टालना क्यों हानिकारक है?",
                    "question_en": "Why is postponing work harmful for a student?",
                    "expected_answer_hi": "क्योंकि इससे काम का बोझ बढ़ता है और असफलता मिलती है",
                    "expected_answer_en": "Because it increases burden and leads to failure",
                    "points": 1
                }
            ],
            "dictation_fallback_words": ["निरंतर", "अनुशासन", "सफलता", "सदुपयोग", "महत्वपूर्ण"],
            "dictation_fallback_words_en": ["continuous", "discipline", "success", "productive", "essential"],
            "review_status": "pending_teacher_review"
        }
    ]
}

with open('assets/passages/bank.json', 'w', encoding='utf-8') as f:
    json.dump(passage_bank, f, indent=2, ensure_ascii=False)

# 5. assets/practice/activities.json
# Exactly 14 original activities in English & Hindi
activities_bank = {
    "version": "1.0",
    "total_activities": 14,
    "review_status": "pending_teacher_review",
    "activities": [
        {
            "id": "act_01",
            "target_need": "matra",
            "title_en": "Short and Long Vowel Sound Match",
            "title_hi": "छोटी और बड़ी मात्रा का खेल",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Teacher writes minimal word pairs (e.g. दिन/दीन, कुल/कूल, मिल/मील) on the board. Children read aloud and tap the desk when hearing the long vowel.",
            "instructions_hi": "शिक्षक श्यामपट्ट पर मात्रा युग्म (जैसे दिन/दीन, कुल/कूल, मिल/मील) लिखते हैं। बच्चे जोर से पढ़ते हैं और लंबी मात्रा पर मेज थपथपाते हैं।",
            "home_activity_en": "Find 3 objects at home that have an 'ee' (ई) sound in their Hindi names.",
            "home_activity_hi": "घर पर ऐसी 3 वस्तुएं खोजें जिनके नाम में बड़ी 'ई' की मात्रा आती हो (जैसे थाली, चाबी)।"
        },
        {
            "id": "act_02",
            "target_need": "conjunct",
            "title_en": "Joined Letter Hunt",
            "title_hi": "संयुक्ताक्षर खोजो और बोलो",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Children find letters joined by halant (क्य, प्र, स्त, त्र) on flash cards, pronounce the blend slowly, then say the full word.",
            "instructions_hi": "फ्लैश कार्ड्स पर आधे अक्षर वाले शब्द (जैसे क्या, पत्ता, पुस्तक, मित्र) खोजें और धीरे-धीरे बोलकर अभ्यास करें।",
            "home_activity_en": "Ask parents to tell 2 words with half-letters and write them in the notebook.",
            "home_activity_hi": "माता-पिता से आधे अक्षर वाले दो शब्द पूछकर कॉपी में लिखें।"
        },
        {
            "id": "act_03",
            "target_need": "bindu",
            "title_en": "Nasal Dot or Moon: Bindu vs Chandrabindu",
            "title_hi": "बिंदु और चंद्रबिंदु की पहचान",
            "duration_minutes": 10,
            "group_codes": ["G2"],
            "instructions_en": "Practice nasalization difference: रंग, पतंग, गेंद (bindu) vs चाँद, आँख, गाँव (chandrabindu). Feel the nose vibration while speaking.",
            "instructions_hi": "बिंदु (रंग, गेंद) और चंद्रबिंदु (चाँद, आँख) वाले शब्दों का अंतर नाक पर उंगली रखकर महसूस करके बोलें।",
            "home_activity_en": "Draw a moon and a dot in your notebook and write 2 words under each.",
            "home_activity_hi": "कॉपी में एक चाँद और एक बिंदु बनाकर दोनों के नीचे दो-दो शब्द लिखें।"
        },
        {
            "id": "act_04",
            "target_need": "word_reading",
            "title_en": "Rapid Decodable Word Roll",
            "title_hi": "द्रुत गति शब्द पठन",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Flash card pyramid: Children take turns reading cards quickly without sounding out individual aksharas letter by letter.",
            "instructions_hi": "शब्द कार्ड का पिरामिड: बच्चे एक-एक अक्षर अलग किए बिना पूरे शब्द को एक नज़र में पढ़ने का अभ्यास करते हैं।",
            "home_activity_en": "Read the 5 practice words printed on your worksheet to an older family member.",
            "home_activity_hi": "अपनी वर्कशीट पर छपे 5 अभ्यास शब्द घर के किसी बड़े सदस्य को पढ़कर सुनाएं।"
        },
        {
            "id": "act_05",
            "target_need": "fluency",
            "title_en": "Echo and Paired Reading",
            "title_hi": "साथ-साथ और प्रतिध्वनि पठन",
            "duration_minutes": 10,
            "group_codes": ["G1", "G3"],
            "instructions_en": "Teacher reads one sentence with natural expression and rhythm; children echo read together, then read in pairs taking turns.",
            "instructions_hi": "शिक्षक उचित लय और भाव के साथ एक वाक्य पढ़ते हैं; बच्चे उसे दोहराते हैं, फिर जोड़ी बनाकर एक-दूसरे को सुनाते हैं।",
            "home_activity_en": "Read the short story on your practice sheet to a younger sibling or parent.",
            "home_activity_hi": "अभ्यास पत्रक की छोटी कहानी अपने छोटे भाई-बहन या माता-पिता को सुनाएं।"
        },
        {
            "id": "act_06",
            "target_need": "facts",
            "title_en": "Detective Story Search",
            "title_hi": "कहानी का जासूस: तथ्य खोजो",
            "duration_minutes": 10,
            "group_codes": ["G3", "G4"],
            "instructions_en": "After reading a 3-sentence passage, teacher asks who, what, and where questions. Children point to the exact word in the text with a finger.",
            "instructions_hi": "गद्यांश पढ़ने के बाद 'कौन', 'कहाँ' और 'क्या' वाले सवाल पूछें। बच्चे उस शब्द पर अपनी उंगली रखकर उत्तर दिखाएं।",
            "home_activity_en": "Tell your family who was in the story you read in class today.",
            "home_activity_hi": "घर पर बताएं कि आज कक्षा में पढ़ी कहानी में कौन-कौन से पात्र थे।"
        },
        {
            "id": "act_07",
            "target_need": "why_how",
            "title_en": "The 'Why and How' Chain",
            "title_hi": "क्यों और कैसे की माला",
            "duration_minutes": 10,
            "group_codes": ["G3"],
            "instructions_en": "Teacher stops mid-story and asks: 'Why did the crow drop pebbles?' Children answer using 'Because... (क्योंकि...)'.",
            "instructions_hi": "कहानी के बीच रुककर पूछें: 'कौवे ने कंकड़ क्यों डाले?' बच्चे 'क्योंकि...' शब्द जोड़कर कारण स्पष्ट करें।",
            "home_activity_en": "Tell someone at home why it is important to save drinking water.",
            "home_activity_hi": "घर पर किसी को समझाएं कि पीने का पानी बचाना क्यों जरूरी है।"
        },
        {
            "id": "act_08",
            "target_need": "word_meaning",
            "title_en": "Word in Action",
            "title_hi": "शब्द और उसका अभिनय",
            "duration_minutes": 10,
            "group_codes": ["G3", "G4"],
            "instructions_en": "Teacher introduces an unfamiliar word (e.g. अनमोल, बलवान, क्षमा). Children act it out or use it in their own classroom sentence.",
            "instructions_hi": "नया शब्द (जैसे बलवान, अनमोल, चंचल) चुनें। बच्चे उसका अभिनय करें या अपनी भाषा में नया वाक्य बनाएं।",
            "home_activity_en": "Ask grandparents the meaning of an old word and tell it in school tomorrow.",
            "home_activity_hi": "दादा-दादी से किसी पुराने शब्द का अर्थ पूछें और कल कक्षा में साझा करें।"
        },
        {
            "id": "act_09",
            "target_need": "spelling",
            "title_en": "Five-Word Notebook Dictation",
            "title_hi": "पाँच शब्दों का श्रुतलेख",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Teacher calls out 5 words from the child's own misread words bank. Child writes carefully, then self-checks against the flashcard.",
            "instructions_hi": "शिक्षक बच्चे के गलत पढ़े शब्दों में से 5 शब्द बोलते हैं। बच्चा कॉपी में लिखता है और कार्ड से मिलान करता है।",
            "home_activity_en": "Write the 5 dictation words neatly three times in your home notebook.",
            "home_activity_hi": "घर की कॉपी में इन 5 शब्दों को तीन बार सुंदर लिखावट में लिखें।"
        },
        {
            "id": "act_10",
            "target_need": "listening",
            "title_en": "Listen and Retell Circle",
            "title_hi": "सुनो और अपनी भाषा में कहो",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Teacher reads aloud a 1-minute engaging story without showing text. Children retell the story points in their home language or school language.",
            "instructions_hi": "शिक्षक बिना किताब दिखाए एक छोटी कहानी सुनाते हैं। बच्चे अपनी घर की भाषा या हिंदी में उसे दोबारा सुनाते हैं।",
            "home_activity_en": "Listen to a bedtime story from parents and retell the beginning, middle, and end.",
            "home_activity_hi": "रात को सोने से पहले माता-पिता से कहानी सुनें और बताएं कि शुरुआत और अंत में क्या हुआ।"
        },
        {
            "id": "act_11",
            "target_need": "home_engagement",
            "title_en": "Daily Family Conversation",
            "title_hi": "परिवार के साथ शाम की बातचीत",
            "duration_minutes": 10,
            "group_codes": ["G1", "G2", "G3", "G4"],
            "instructions_en": "Home activity: The child shares one interesting fact or word learned in school today with their parents.",
            "instructions_hi": "घर की गतिविधि: बच्चा आज स्कूल में सीखा कोई एक नया शब्द या ज्ञान अपने माता-पिता के साथ साझा करता है।",
            "home_activity_en": "Tell your parents what Kiran the mascot did today in school.",
            "home_activity_hi": "माता-पिता को बताएं कि आज स्कूल में आपने क्या नया पढ़ा।"
        },
        {
            "id": "act_12",
            "target_need": "akshara_awareness",
            "title_en": "Syllable Clapping Game",
            "title_hi": "ताली बजाकर अक्षर गिनो",
            "duration_minutes": 10,
            "group_codes": ["G2", "G4"],
            "instructions_en": "Children break words into akshara beats by clapping (e.g., पा-नी = 2 claps, कि-ता-ब = 3 claps).",
            "instructions_hi": "शब्दों को अक्षरों में तोड़कर ताली बजाएं (जैसे: पा-नी = 2 ताली, कि-ता-ब = 3 ताली)।",
            "home_activity_en": "Clap out the syllables of all family members' names at dinner.",
            "home_activity_hi": "रात के भोजन के समय परिवार के सभी सदस्यों के नामों पर ताली बजाकर अक्षर गिनें।"
        },
        {
            "id": "act_13",
            "target_need": "sentence_building",
            "title_en": "Sentence Train",
            "title_hi": "वाक्य रेलगाड़ी",
            "duration_minutes": 10,
            "group_codes": ["G3", "G4"],
            "instructions_en": "Children arrange jumbled word cards into a meaningful grammatically correct sentence.",
            "instructions_hi": "उलटे-पुलटे शब्द कार्ड्स को सही क्रम में लगाकर सार्थक वाक्य बनाएं।",
            "home_activity_en": "Make a sentence using the words 'पेड़' and 'पानी' and tell your family.",
            "home_activity_hi": "'पेड़' और 'पानी' शब्दों का प्रयोग करके एक वाक्य बनाएं और घर में सुनाएं।"
        },
        {
            "id": "act_14",
            "target_need": "expression",
            "title_en": "Poem Recitation with Gestures",
            "title_hi": "हाव-भाव के साथ कविता पाठ",
            "duration_minutes": 10,
            "group_codes": ["G1", "G3"],
            "instructions_en": "Children recite a 4-line rhyming poem with facial expressions, body gestures, and voice modulation.",
            "instructions_hi": "हाव-भाव और आवाज़ के उतार-चढ़ाव के साथ 4 पंक्तियों की लयबद्ध कविता सुनाएं।",
            "home_activity_en": "Recite your favorite rhyme to family members before dinner.",
            "home_activity_hi": "रात के खाने से पहले अपनी मनपसंद कविता परिवार को हाव-भाव के साथ सुनाएं।"
        }
    ]
}

with open('assets/practice/activities.json', 'w', encoding='utf-8') as f:
    json.dump(activities_bank, f, indent=2, ensure_ascii=False)

print("Generated all core JSON assets successfully.")
