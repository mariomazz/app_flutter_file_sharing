import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/pages/chat.dart';
import '../../../ui/pages/home.dart';
import '../../../ui/pages/notifications.dart';
import '../../../ui/pages/settings.dart';
import '../../../ui/widgets/tabbat_navigation.dart';
import 'routes.dart';

class Routing with ChangeNotifier {
  Routing() {
    goRouter.addListener(notifyListeners);
  }

  final GoRouter _goRouter = GoRouter(
    initialLocation: homeRoute,
    routes: [
      GoRoute(path: initialRoute, redirect: (ctx, state) => homeRoute),
      ShellRoute(
        builder: (ctx, state, widget) => TabbarNavigation(child: widget),
        routes: [
          GoRoute(
            path: homeRoute,
            builder: (ctx, state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: chatRoute,
            builder: (ctx, state) {
              return const ChatPage();
            },
          ),
          GoRoute(
            path: settingsRoute,
            builder: (ctx, state) {
              return const SettingsPage();
            },
          ),
          GoRoute(
            path: notificationsRoute,
            builder: (ctx, state) {
              return const NotificationsPage();
            },
          ),
        ],
      ),
    ],
    redirect: (ctx, state) {
      return null;
    },
  );

  GoRouter get goRouter => _goRouter;
}
