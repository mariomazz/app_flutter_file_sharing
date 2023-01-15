import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/pages/home.dart';
import '../../utils/logger.dart';
import 'routes.dart';

class Routing with ChangeNotifier {
  Routing() {
    _init();
  }

  final GoRouter _goRouter = GoRouter(
    initialLocation: homeRoute,
    routes: [
      GoRoute(
        path: initialRoute,
        redirect: (ctx, state) {
          return homeRoute;
        },
      ),
      GoRoute(
        path: homeRoute,
        builder: (ctx, state) {
          return const HomePage();
        },
      ),
    ],
    redirect: (ctx, state) {
      return null;
    },
  );

  GoRouter get goRouter => _goRouter;

  void _init() {
    goRouter.addListener(() {
      Logger.log("Routing Update");
      notifyListeners();
    });
  }
}
