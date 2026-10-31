import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class ActiveClassHeaderChip extends ConsumerWidget {
  const ActiveClassHeaderChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final classes = ref.watch(classesForScopeStreamProvider).value ?? [];
    final l10n = AppLocalizations.of(context)!;

    if (activeClass == null) return const SizedBox.shrink();

    return InkWell(
      key: const Key('active_class_header_chip'),
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (classes.length <= 1) return;
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    l10n.switchClass,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: SamajhColors.textNavy,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ...classes.map((c) {
                  final isSelected = c.id == activeClass.id;
                  return ListTile(
                    leading: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? SamajhColors.forestGreen : SamajhColors.textMuted,
                    ),
                    title: Text(
                      c.name,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: SamajhColors.textNavy,
                      ),
                    ),
                    subtitle: Text(
                      "${l10n.gradeLabel} ${c.grade}${c.section.isNotEmpty ? ' · Section ${c.section}' : ''} · ${c.checkLanguage == 'en' ? 'English' : 'हिंदी'}",
                      style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      switchActiveClass(ref, c.id);
                    },
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: SamajhColors.paleMint,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: SamajhColors.forestGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, size: 14, color: SamajhColors.forestGreen),
            const SizedBox(width: 5),
            Text(
              activeClass.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: SamajhColors.forestGreen,
              ),
            ),
            if (classes.length > 1) ...[
              const SizedBox(width: 2),
              const Icon(Icons.arrow_drop_down, size: 16, color: SamajhColors.forestGreen),
            ],
          ],
        ),
      ),
    );
  }
}
