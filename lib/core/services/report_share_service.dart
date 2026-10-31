import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../i18n/generated/app_localizations.dart';

class ReportShareService {
  static pw.Font? _devanagariFont;
  static pw.Font? _devanagariBoldFont;
  static pw.Font? _interFont;
  static pw.Font? _interBoldFont;

  static Future<void> _loadFonts() async {
    try {
      if (_devanagariFont == null) {
        final fontData = await rootBundle.load('assets/fonts/noto_sans_devanagari/NotoSansDevanagari-Regular.ttf');
        _devanagariFont = pw.Font.ttf(fontData);
      }
      if (_devanagariBoldFont == null) {
        final fontData = await rootBundle.load('assets/fonts/noto_sans_devanagari/NotoSansDevanagari-Bold.ttf');
        _devanagariBoldFont = pw.Font.ttf(fontData);
      }
      if (_interFont == null) {
        final fontData = await rootBundle.load('assets/fonts/inter/Inter-Regular.ttf');
        _interFont = pw.Font.ttf(fontData);
      }
      if (_interBoldFont == null) {
        final fontData = await rootBundle.load('assets/fonts/inter/Inter-Bold.ttf');
        _interBoldFont = pw.Font.ttf(fontData);
      }
    } catch (_) {}
  }

  /// Generates a PDF for parent report with strictly first name only and zero scores/red marks
  static Future<Uint8List> generateParentReportPdf({
    required String childFirstName,
    required String homeActivity,
    required bool isHindi,
  }) async {
    await _loadFonts();
    final doc = pw.Document();

    final regularFont = isHindi ? (_devanagariFont ?? pw.Font.helvetica()) : (_interFont ?? pw.Font.helvetica());
    final boldFont = isHindi ? (_devanagariBoldFont ?? pw.Font.helveticaBold()) : (_interBoldFont ?? pw.Font.helveticaBold());

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      isHindi ? 'समझ (Samajh) - अभिभावक रिपोर्ट' : 'Samajh - Parent Report',
                      style: pw.TextStyle(font: boldFont, fontSize: 18),
                    ),
                    pw.Text(
                      DateTime.now().toLocal().toString().split(' ')[0],
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                isHindi
                    ? 'विद्यार्थी: $childFirstName'
                    : 'Learner: $childFirstName',
                style: pw.TextStyle(font: boldFont, fontSize: 16),
              ),
              pw.SizedBox(height: 14),
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  color: PdfColors.grey100,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      isHindi
                          ? 'नमस्ते! $childFirstName कक्षा में मन लगाकर पढ़ने का अच्छा प्रयास कर रहे हैं।'
                          : 'Namaste! $childFirstName is putting sincere effort into classroom reading.',
                      style: pw.TextStyle(font: boldFont, fontSize: 14),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      isHindi
                          ? 'आज के पठन अभ्यास में बच्चे ने बहुत से शब्द सही और आत्मविश्वास से पढ़े। समझ के प्रश्नों का भी अच्छा उत्तर दिया।'
                          : 'During today\'s check, the learner read words confidently and showed good understanding of story questions.',
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      isHindi ? 'घर पर करने योग्य गतिविधि:' : 'Recommended Home Activity:',
                      style: pw.TextStyle(font: boldFont, fontSize: 12, color: PdfColors.green900),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      homeActivity,
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                isHindi
                    ? 'नोट: यह रिपोर्ट केवल प्रोत्साहन और सीखने में सहयोग के लिए है। इसमें कोई अंक या श्रेणी नहीं है।'
                    : 'Note: This report is purely for encouragement and supportive home practice. It contains zero marks or rankings.',
                style: pw.TextStyle(font: regularFont, fontSize: 10, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                isHindi
                    ? 'नोट: ऐप उच्चारण का स्वतः पता नहीं लगाता है; शिक्षक द्वारा पठन का प्रत्यक्ष अवलोकन किया गया है।'
                    : 'Note: Samajh does not automatically detect pronunciation; reading was evaluated directly by the teacher.',
                style: pw.TextStyle(font: regularFont, fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  /// Generates a PDF for anonymized class aggregate summary
  static Future<Uint8List> generateClassSummaryPdf({
    required String className,
    required int checkedCount,
    required int totalCount,
    required int onTrackCount,
    required int needsHelpCount,
    required bool isHindi,
  }) async {
    await _loadFonts();
    final doc = pw.Document();

    final regularFont = isHindi ? (_devanagariFont ?? pw.Font.helvetica()) : (_interFont ?? pw.Font.helvetica());
    final boldFont = isHindi ? (_devanagariBoldFont ?? pw.Font.helveticaBold()) : (_interBoldFont ?? pw.Font.helveticaBold());

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      isHindi ? 'समझ (Samajh) - कक्षा प्रगति सारांश' : 'Samajh - Class Progress Summary',
                      style: pw.TextStyle(font: boldFont, fontSize: 18),
                    ),
                    pw.Text(
                      DateTime.now().toLocal().toString().split(' ')[0],
                      style: pw.TextStyle(font: regularFont, fontSize: 12),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                '$className (${isHindi ? "समग्र रिपोर्ट" : "Aggregate Report"})',
                style: pw.TextStyle(font: boldFont, fontSize: 16),
              ),
              pw.SizedBox(height: 14),
              pw.TableHelper.fromTextArray(
                context: ctx,
                headerStyle: pw.TextStyle(font: boldFont, fontSize: 12, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.green800),
                cellStyle: pw.TextStyle(font: regularFont, fontSize: 12),
                headers: isHindi
                    ? ['मापदंड', 'विद्यार्थी गणना']
                    : ['Metric', 'Count'],
                data: [
                  [isHindi ? 'कुल विद्यार्थी' : 'Total Students', '$totalCount'],
                  [isHindi ? 'जांचे गए विद्यार्थी' : 'Assessed Students', '$checkedCount'],
                  [isHindi ? 'लक्ष्य पर (On Track)' : 'On Track', '$onTrackCount'],
                  [isHindi ? 'सहयोग की आवश्यकता' : 'Needs Support', '$needsHelpCount'],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                isHindi
                    ? 'गोपनीयता सूचना: इस रिपोर्ट में किसी भी बच्चे का व्यक्तिगत डेटा या नाम शामिल नहीं है।'
                    : 'Privacy Notice: This report contains only aggregated statistics with zero individual personal data.',
                style: pw.TextStyle(font: regularFont, fontSize: 10, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                isHindi
                    ? 'नोट: ऐप उच्चारण का स्वतः पता नहीं लगाता है; पठन का मूल्यांकन शिक्षक द्वारा प्रत्यक्ष रूप से किया जाता है।'
                    : 'Note: Samajh does not automatically detect pronunciation; reading was evaluated directly by the teacher.',
                style: pw.TextStyle(font: regularFont, fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  /// Generates a PDF for practice worksheet
  static Future<Uint8List> generateWorksheetPdf({
    required String childFirstName,
    required String activityTitle,
    required String instructions,
    required bool isHindi,
  }) async {
    await _loadFonts();
    final doc = pw.Document();

    final regularFont = isHindi ? (_devanagariFont ?? pw.Font.helvetica()) : (_interFont ?? pw.Font.helvetica());
    final boldFont = isHindi ? (_devanagariBoldFont ?? pw.Font.helveticaBold()) : (_interBoldFont ?? pw.Font.helveticaBold());

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      isHindi ? 'समझ अभ्यास कार्यपत्रक' : 'Samajh Practice Worksheet',
                      style: pw.TextStyle(font: boldFont, fontSize: 18),
                    ),
                    pw.Text(
                      childFirstName,
                      style: pw.TextStyle(font: boldFont, fontSize: 14),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 14),
              pw.Text(
                activityTitle,
                style: pw.TextStyle(font: boldFont, fontSize: 16),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                instructions,
                style: pw.TextStyle(font: regularFont, fontSize: 12),
              ),
              pw.SizedBox(height: 24),
              pw.Container(
                height: 300,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Center(
                  child: pw.Text(
                    isHindi ? 'पठन व लेखन अभ्यास क्षेत्र' : 'Practice & Writing Area',
                    style: pw.TextStyle(font: regularFont, fontSize: 12, color: PdfColors.grey500),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  /// Print action (uses system printing)
  static Future<void> printPdf({
    required Uint8List pdfBytes,
    required String jobName,
  }) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: jobName,
    );
  }

  /// Share action (saves to temp cache, displays warning, shares via share_plus, deletes file)
  static Future<void> sharePdf({
    required BuildContext context,
    required Uint8List pdfBytes,
    required String firstNameOnly,
    required String reportType,
  }) async {
    final l10n = AppLocalizations.of(context)!;

    // Show one-line warning that shared files leave the phone
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.shareWarningNote),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Sanitize filename to only first name (no last names or full ID)
    final cleanName = firstNameOnly.trim().split(RegExp(r'\s+')).first;
    final fileName = '${cleanName.isNotEmpty ? cleanName : "learner"}_$reportType.pdf';

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');

    try {
      await file.writeAsBytes(pdfBytes);
      final xFile = XFile(file.path, mimeType: 'application/pdf', name: fileName);
      // ignore: deprecated_member_use
      await Share.shareXFiles([xFile], text: 'Samajh Report');
    } finally {
      // Clean up temp file immediately after share sheet returns
      if (await file.exists()) {
        try {
          await file.delete();
        } catch (_) {}
      }
    }
  }
}
