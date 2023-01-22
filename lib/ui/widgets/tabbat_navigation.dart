import 'package:app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/providers.dart';
import '../../core/providers/routing/routes.dart';

class TabbarNavigation extends ConsumerWidget {
  final Widget child;

  const TabbarNavigation({super.key, required this.child});

  int calculateIndexByRoute(String route) {
    switch (route) {
      case homeRoute:
        return 0;
      case chatRoute:
        return 1;
      case notificationsRoute:
        return 2;
      case settingsRoute:
        return 3;
      default:
        return 0;
    }
  }

  void navByIndex(GoRouter nav, BuildContext ctx, int index) {
    switch (index) {
      case 0:
        return nav.go(homeRoute);
      case 1:
        return nav.go(chatRoute);
      case 2:
        return nav.go(notificationsRoute);
      case 3:
        return nav.go(settingsRoute);
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routing = ref.watch(routingProvider);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: calculateIndexByRoute(routing.goRouter.location),
        onTap: (index) => navByIndex(routing.goRouter, context, index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: iconPrimary(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: iconPrimary(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: iconPrimary(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: iconPrimary(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
