/// Picks a class's own levels out of a practice bank.
///
/// Banks can hold class-wise Hindi levels under `hindi_by_grade`, for example
/// `{"hindi_by_grade": {"1": {"level_1": [...], ...}}}`. A class with its own
/// entry uses those levels; any level it lacks, and every class without an
/// entry, falls back to the shared `hindi` (or `english`) levels.
library;

Map<String, dynamic> levelsForGrade(Map<String, dynamic> bank, {required bool isHindi, required int grade}) {
  final lang = isHindi ? 'hindi' : 'english';
  final shared = Map<String, dynamic>.from(bank[lang] as Map? ?? const {});
  final own = (bank['${lang}_by_grade'] as Map?)?['$grade'] as Map?;
  if (own == null) return shared;
  return {...shared, ...own.cast<String, dynamic>()};
}
