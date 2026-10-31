# Hindi Classes 1–3: how the questions follow NCERT

Checked on 31 October 2026. Every item described here is original Samajh content and **awaits teacher review**. Nothing is official until a teacher has checked it.

## Sources read

| Source | Used for | Where |
|---|---|---|
| NCERT, *Learning Outcomes at the Foundational Stage*, Hindi (R1) table | Class 1 and Class 2 outcomes | [PDF](https://ncert.nic.in/pdf/publication/otherpublications/Learning_Outcome_for_the_Foundational_Stage.pdf), printed pp. 36–40 |
| NCERT *Veena* (Class 3, 2024), "पाठ्यपुस्तक के विषय में" | NCF-SE 2023 Preparatory Stage curricular goals for Hindi | [prelims PDF](https://ncert.nic.in/textbook/pdf/chve1ps.pdf), p. v |
| Contents pages of *Sarangi 1*, *Sarangi 2*, *Veena* (Reprint 2026-27) | Units (themes) and the first chapters | ahsr1ps.pdf, bhsr1ps.pdf, chve1ps.pdf on ncert.nic.in |

The outcomes are stored, with a close Hindi paraphrase and an English gloss, in `assets/curriculum/hindi_outcomes_g1_3.json`. Each word-check item, typing list and Class 1–3 passage question points to the outcome it checks.

**Limit:** Class 3 uses the NCF-SE *curricular goals*. NCERT's grade-level learning outcomes for Class 3 were not checked.

## What changes by class

| | Class 1 | Class 2 | Class 3 |
|---|---|---|---|
| Textbook units (themes only) | परिवार, जीव-जगत, हमारा खान-पान, त्योहार और मेले, हरी-भरी दुनिया | परिवार, रंग ही रंग, हरी-भरी धरती, मित्रता, आकाश | हमारा पर्यावरण, हमारे मित्र, आओ खेलें, अपना-अपना काम, हमारा देश |
| Level 1: picture word | 2–3 akshara words, mostly without matras. Distractors start with the same sound (FS C-10.1, C-10.3 G1) | Words with all matras (FS C-10.3 G2) | Conjunct and र-form words: ट्रैक्टर, स्टेशन, पत्र (FS C-10.3 G2 secured; CG-4) |
| Level 2: spelling | 3–4 akshara words; first matras; letters in the wrong order (C-10.3, C-10.8 G1) | इ/ई, उ/ऊ, dropped half letters (C-10.3 G2) | प्रकृति, मित्र, विद्यालय: half letters, र forms, श/स (CG-3) |
| Level 3: writing and sentences | Line position, letter formation, one sentence blank (C-10.8, C-10.4 G1) | Formation and sentence blanks (C-10.4 G2) | Sentence blanks from unit themes (CG-2, CG-3) |
| Level 4: meaning | Heard two-line story: recall and simple inference (C-10.5 G1) | Guess a word's meaning from context (C-9.7 G2), cause, prediction (C-10.5 G2) | Idioms and words in context, inference, main idea (CG-2, CG-4) |
| Typing | No-matra words, then the first matras (C-10.8 G1: 3–4 akshara words in dictation) | All matras, then conjuncts (C-10.3 G2) | Conjuncts and र forms (CG-3) |
| Passage questions | fact, then a simple why (C-10.5 G1) | fact, word meaning from context, why, main idea (C-10.5, C-9.7 G2) | fact, word meaning, why/how, main idea (CG-2, CG-4) |

Every child still starts at Level 1 (D021). The class decides *which* Level 1 items the child sees. Classes 4–5 and English use the shared bank as before.

## Fixed while doing this

- `registry.json` had errors in chapter lists marked "verified": Class 2 chapters 4–5 were wrong (they are माँ and थाथू और मैं), and the Class 3 Veena list was mostly wrong (it is सीखो, चींटी, कितने पैर?, बया हमारी चिड़िया रानी!, आम का पेड़). Page numbers were corrected and units added. The Class 4 and 5 NCERT lists are now marked unverified because they were not checked.
- Passage `p_g2_02` closely followed a known Class 2 textbook story. It was replaced with an original story, "एक छाता, दो दोस्त". Children may have memorised textbook stories, and copying them raises copyright problems.
- `p_g2_01`, `p_g3_01` and `p_g3_02` are well-known fables. They carry a `familiarity_note`, because a child who knows the story may find the questions easier.
- Typed answers accept both standard spellings of a nasal before a consonant (बंदर / बन्दर).

## Still to do

- Teacher review of all items (marked `awaiting teacher review`).
- Check NCERT's Class 3 learning outcomes, and Classes 4–5.
- Re-check the UP H-codes against the UP documents.
- English Classes 1–3 are not yet class-wise.
