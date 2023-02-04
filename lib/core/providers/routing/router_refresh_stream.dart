import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

/// This class was imported from the migration guide for GoRouter 5.0
/// support to list Streams
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream({List<Stream<dynamic>> streams = const []}) {
    notifyListeners();
    _subscription = MergeStream<dynamic>(streams)
        .asBroadcastStream()
        .listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
