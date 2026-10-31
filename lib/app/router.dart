import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/database/app_database.dart';
import '../core/providers/database_provider.dart';
import '../features/setup/welcome_screen.dart';
import '../features/setup/privacy_promise_screen.dart';
import '../features/setup/passcode_setup_screen.dart';
import '../features/setup/class_setup_screen.dart';
import '../features/setup/unlock_screen.dart';
import '../features/today/today_screen.dart';
import '../features/class_roster/class_screen.dart';
import '../features/practice/practice_tab.dart';
import '../features/reports/reports_tab.dart';
import '../features/reports/milestones_page.dart';
import '../features/class_roster/class_settings_screen.dart';
import '../features/class_roster/child_profile_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/settings/privacy_checklist_screen.dart';
import '../features/settings/privacy_center_screen.dart';
import '../features/settings/about_screen.dart';
import '../features/check_flow/check_flow_page.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/teacher_profile_edit_screen.dart';
import '../features/profile/class_students_screen.dart';
import 'app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isUnlocked = false;
  String? _passcodeHash;
  bool _isInitialized = false;
  bool _hasRealClass = false;

  AppRouterNotifier(this._ref) {
    _ref.listen<bool>(isAppUnlockedProvider, (previous, next) {
      if (_isUnlocked != next) {
        _isUnlocked = next;
        notifyListeners();
      }
    });

    _ref.listen<AsyncValue<AppSettingsTableData?>>(appSettingsStreamProvider, (previous, next) {
      final newHash = next.value?.passcodeHash;
      final initialized = next.hasValue;
      if (_passcodeHash != newHash || _isInitialized != initialized) {
        _passcodeHash = newHash;
        _isInitialized = initialized;
        notifyListeners();
      }
    });

    _ref.listen<AsyncValue<List<ClassesTableData>>>(realClassesStreamProvider, (previous, next) {
      final hasReal = next.value?.isNotEmpty ?? false;
      if (_hasRealClass != hasReal) {
        _hasRealClass = hasReal;
        notifyListeners();
      }
    });

    _isUnlocked = _ref.read(isAppUnlockedProvider);
    final settingsAsync = _ref.read(appSettingsStreamProvider);
    _isInitialized = settingsAsync.hasValue;
    _passcodeHash = settingsAsync.value?.passcodeHash;
    final realClassesAsync = _ref.read(realClassesStreamProvider);
    _hasRealClass = realClassesAsync.value?.isNotEmpty ?? false;
  }

  bool get isUnlocked => _isUnlocked;
  bool get hasPasscode => _passcodeHash != null && _passcodeHash!.isNotEmpty;
  bool get hasRealClass => _hasRealClass;
  bool get isInitialized => _isInitialized;
}

final routerNotifierProvider = Provider<AppRouterNotifier>((ref) {
  final notifier = AppRouterNotifier(ref);
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

List<RouteBase> _buildAppRoutes() => [
  GoRoute(
    path: '/unlock',
    builder: (context, state) => const UnlockScreen(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/privacy',
    builder: (context, state) => const PrivacyPromiseScreen(),
  ),
  GoRoute(
    path: '/passcode',
    builder: (context, state) => const PasscodeSetupScreen(),
  ),
  GoRoute(
    path: '/class_setup',
    builder: (context, state) => const ClassSetupScreen(),
  ),
  GoRoute(
    path: '/app',
    redirect: (context, state) => '/app/today',
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return AppShell(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/app/today',
            builder: (context, state) => const TodayScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/app/class',
            builder: (context, state) => const ClassScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/app/practice',
            builder: (context, state) => const PracticeTab(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/app/reports',
            builder: (context, state) => const ReportsTab(),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: '/profile_edit',
    builder: (context, state) => const TeacherProfileEditScreen(),
  ),
  GoRoute(
    path: '/class_students',
    builder: (context, state) {
      final classId = state.uri.queryParameters['classId'] ?? '';
      return ClassStudentsScreen(classId: classId);
    },
  ),
  GoRoute(
    path: '/privacy_checklist',
    builder: (context, state) => const PrivacyChecklistScreen(),
  ),
  GoRoute(
    path: '/class_settings',
    builder: (context, state) => const ClassSettingsScreen(),
  ),
  GoRoute(
    path: '/child_profile',
    builder: (context, state) {
      final childId = state.uri.queryParameters['childId'] ?? '';
      return ChildProfileScreen(childId: childId);
    },
  ),
  GoRoute(
    path: '/check_flow',
    builder: (context, state) {
      final childId = state.uri.queryParameters['childId'] ?? '';
      return CheckFlowPage(childId: childId);
    },
  ),
  GoRoute(
    path: '/milestones',
    builder: (context, state) => const MilestonesPage(),
  ),
  GoRoute(
    path: '/privacy_center',
    builder: (context, state) => const PrivacyCenterScreen(),
  ),
  GoRoute(
    path: '/about',
    builder: (context, state) => const AboutScreen(),
  ),
  GoRoute(
    path: '/backup_restore',
    redirect: (context, state) => '/settings',
  ),
];

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: notifier,
    initialLocation: '/',
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isGoingToUnlock = location == '/unlock';
      final isGoingToOnboarding = location == '/' ||
          location == '/privacy' ||
          location == '/passcode';
      final isGoingToClassSetup = location == '/class_setup';

      // 1. If teacher has not set a passcode yet, keep them in onboarding
      if (!notifier.hasPasscode) {
        if (isGoingToUnlock || location.startsWith('/app') || isGoingToClassSetup) {
          return '/';
        }
        return null;
      }

      // 2. Teacher has set passcode but has not created their real class yet:
      // This is the first-time onboarding step right after passcode setup!
      if (!notifier.hasRealClass) {
        if (!notifier.isUnlocked) {
          if (!isGoingToUnlock) return '/unlock';
          return null;
        }
        if (!isGoingToClassSetup) {
          return '/class_setup';
        }
        return null;
      }

      // 3. Teacher has passcode AND has created their class:
      // Must be unlocked for this session
      if (!notifier.isUnlocked) {
        if (!isGoingToUnlock) {
          return '/unlock';
        }
        return null;
      }

      // 4. Teacher has passcode, has created class, and is unlocked:
      // When opening the app later or navigating back to onboarding / class_setup,
      // it MUST NOT ask for class details again! Redirect straight to /app/today.
      if (isGoingToUnlock || isGoingToOnboarding || isGoingToClassSetup) {
        return '/app/today';
      }

      return null;
    },
    routes: _buildAppRoutes(),
  );
});

final samajhRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: _buildAppRoutes(),
);
