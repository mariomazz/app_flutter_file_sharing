/* import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/routing/routes.dart';

class Navigation extends StatelessWidget {
  final Widget child;
  const Navigation({super.key, required this.child});

  void goTo(BuildContext context, int index) {
    if (index == 0) {
      context.go(homeRoute);
    } else if (index == 1) {
      context.go(profileRoute);
    } else {
      context.go(homeRoute);
    }
  }

  int getIndex(BuildContext context) {
    final path = GoRouter.of(context).location;
    if (path == homeRoute) {
      return 0;
    } else if (path == profileRoute) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => goTo(context, index),
        currentIndex: getIndex(context),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
 */