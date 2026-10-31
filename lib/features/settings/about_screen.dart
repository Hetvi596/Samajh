import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isHindi = Localizations.localeOf(context).languageCode == 'hi';

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(isHindi ? "के बारे में और आधिकारिक स्रोत" : "About & Official Sources"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // App Identity Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "समझ Samajh",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: SamajhColors.forestGreen),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isHindi ? "हर बच्चे की समझ को जानें" : "See what every child understands",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isHindi
                        ? "समझ प्राथमिक शिक्षकों (कक्षा 1 से 5) के लिए एक 100% ऑफ़लाइन मूलभूत साक्षरता नैदानिक उपकरण है। यह पठन प्रवाह, सुनकर समझने की क्षमता, कहानी पुनर्कथन और श्रुतलेख का आकलन करता है तथा 10-मिनट के लक्षित अभ्यास में मदद करता है।"
                        : "Samajh is an offline-first foundational literacy diagnostic tool designed for primary teachers in Classes 1 to 5. It assesses reading fluency, listening comprehension, story retelling, and dictation, guiding immediate 10-minute targeted interventions.",
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              isHindi ? "आधिकारिक मानक और संदर्भ" : "Official Benchmarks & References",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
            ),
            const SizedBox(height: 12),
            // Source 1: NCERT FLS 2022
            _SourceCard(
              title: isHindi ? "NCERT मूलभूत शिक्षण अध्ययन (FLS) 2022" : "NCERT Foundational Learning Study (FLS) 2022",
              authority: isHindi ? "राष्ट्रीय शैक्षिक अनुसंधान और प्रशिक्षण परिषद" : "National Council of Educational Research and Training",
              description: isHindi
                  ? "कक्षा 3 मौखिक पठन प्रवाह और समझ के लिए सत्यापित बेंचमार्क प्रदान करता है (लक्ष्य बैंड: 35-54 सही शब्द प्रति मिनट)।"
                  : "Provides verified Hindi and regional language benchmark performance bands for Grade 3 oral reading fluency with comprehension (meets band: 35-54 correct words per minute).",
              codes: const ["FLS 2022 Hindi Benchmark", "NCERT FLN Framework"],
            ),
            const SizedBox(height: 12),
            // Source 2: UP NIPUN Lakshya
            _SourceCard(
              title: isHindi ? "उत्तर प्रदेश निपुण लक्ष्य (FLN मिशन)" : "UP NIPUN Lakshya (FLN Mission)",
              authority: isHindi ? "बेसिक शिक्षा विभाग, उत्तर प्रदेश सरकार" : "Department of Basic Education, Government of Uttar Pradesh",
              description: isHindi
                  ? "प्राथमिक कक्षाओं के लिए पठन गति और समझ के आधिकारिक लक्ष्य (कक्षा 3: अपठित पाठ्यांश पर 75% समझ के साथ कम से कम 60 शब्द प्रति मिनट)।"
                  : "Official reading speed and understanding targets for primary schools (Class 3: at least 60 words per minute on an unseen text with 75% comprehension).",
              codes: const ["UP NIPUN H306", "NIPUN Bharat Guidelines"],
            ),
            const SizedBox(height: 12),
            // Source 3: NCF-FS
            _SourceCard(
              title: isHindi ? "बुनियादी स्तर के लिए राष्ट्रीय पाठ्यचर्या रूपरेखा (NCF-FS)" : "National Curriculum Framework for Foundational Stage (NCF-FS)",
              authority: isHindi ? "शिक्षा मंत्रालय, भारत सरकार" : "Ministry of Education, Government of India",
              description: isHindi
                  ? "भाषा सीखने की प्रगति, मौखिक भाषा दक्षता, ध्वनि जागरूकता और अक्षर-मात्रा शिक्षण पद्धति का मार्गदर्शन करता है।"
                  : "Informs language learning progression, oral language competence, phonological awareness, and akshara-matra pedagogy.",
              codes: const ["NCF-FS Competencies", "Devanagari Akshara Pedagogy"],
            ),
            const SizedBox(height: 12),
            // Source 4: Bundled Offline Repositories
            _SourceCard(
              title: isHindi ? "ऑफ़लाइन ज्ञान भंडार (Bundled Assets)" : "Bundled Offline Knowledge Bank",
              authority: isHindi ? "समझ ऐप में अंतर्निहित आधिकारिक स्रोत" : "Samajh Bundled Assets (Verified Government Reprints)",
              description: isHindi
                  ? "सभी पाठ्यपुस्तक मैपिंग, अध्याय और गद्यांश विशेष रूप से ऐप में मौजूद registry.json, benchmarks.json, bank.json से लिए गए हैं। इंटरनेट की कभी आवश्यकता नहीं होती।"
                  : "All textbook mappings, chapter progressions, and passages are derived exclusively from verified registry.json, benchmarks.json, bank.json, and activities.json. No internet connection is ever required.",
              codes: const ["registry.json", "benchmarks.json", "bank.json"],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  final String title;
  final String authority;
  final String description;
  final List<String> codes;

  const _SourceCard({
    required this.title,
    required this.authority,
    required this.description,
    required this.codes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: SamajhColors.textNavy)),
          const SizedBox(height: 4),
          Text(authority, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.forestGreen)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.4)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: codes.map((c) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: SamajhColors.paleMint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  c,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
