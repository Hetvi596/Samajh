import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/motion.dart';
import '../app/theme.dart';
import '../core/i18n/generated/app_localizations.dart';

class AppShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final canPop = navigationShell.currentIndex == 0;

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (navigationShell.currentIndex != 0) {
          navigationShell.goBranch(0);
        }
      },
      child: Scaffold(
        backgroundColor: SamajhColors.background,
        body: _TabFade(index: navigationShell.currentIndex, child: navigationShell),
        bottomNavigationBar: _PebbleNavBar(
          currentIndex: navigationShell.currentIndex,
          onSelected: _onItemTapped,
          items: [
            _NavItem(const Key('tab_today_button'), Icons.wb_sunny_rounded, l10n.tabToday),
            _NavItem(const Key('tab_class_button'), Icons.groups_rounded, l10n.tabClass),
            _NavItem(const Key('tab_practice_button'), Icons.auto_stories_rounded, l10n.tabPractice),
            _NavItem(const Key('tab_reports_button'), Icons.bar_chart_rounded, l10n.tabReports),
          ],
        ),
      ),
    );
  }
}

/// Tabs keep their state (they live in an IndexedStack), so instead of a
/// cross-fade the newly chosen tab fades and rises in a few pixels.
class _TabFade extends StatefulWidget {
  final int index;
  final Widget child;

  const _TabFade({required this.index, required this.child});

  @override
  State<_TabFade> createState() => _TabFadeState();
}

class _TabFadeState extends State<_TabFade> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: SamajhMotion.base, value: 1);
  late final Animation<double> _t = CurvedAnimation(parent: _c, curve: SamajhMotion.enter);

  @override
  void didUpdateWidget(_TabFade old) {
    super.didUpdateWidget(old);
    if (old.index != widget.index && !SamajhMotion.reduced(context)) _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      child: widget.child,
      builder: (context, child) => Opacity(
        opacity: 0.35 + 0.65 * _t.value,
        child: Transform.translate(offset: Offset(0, (1 - _t.value) * 10), child: child),
      ),
    );
  }
}

class _NavItem {
  final Key key;
  final IconData icon;
  final String label;

  const _NavItem(this.key, this.icon, this.label);
}

/// Floating navy pill. The open tab grows into a gold pill with its name;
/// the others show only their icon (their names are still read out).
class _PebbleNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final List<_NavItem> items;

  const _PebbleNavBar({required this.currentIndex, required this.onSelected, required this.items});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: SamajhColors.textNavy,
            borderRadius: BorderRadius.circular(999),
            boxShadow: SamajhShadow.raised(SamajhColors.textNavy),
          ),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  flex: i == currentIndex ? 5 : 3,
                  child: _NavButton(item: items[i], selected: i == currentIndex, onTap: () => onSelected(i)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({required this.item, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final duration = SamajhMotion.reduced(context) ? Duration.zero : SamajhMotion.base;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: Tooltip(
        message: item.label,
        child: InkWell(
          key: item.key,
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: AnimatedContainer(
            duration: duration,
            curve: SamajhMotion.enter,
            decoration: BoxDecoration(
              color: selected ? SamajhColors.kiranGold : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 22, color: selected ? SamajhColors.textNavy : const Color(0xFFBFC9D9)),
                if (selected) ...[
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
