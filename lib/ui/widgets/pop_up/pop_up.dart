import 'package:flutter/material.dart';

import '../progress.dart';

class PopUp extends StatelessWidget {
  const PopUp({
    Key? key,
    required this.controller,
    required this.child,
    this.builder = const Progress(),
    this.background = _color,
    this.opacity = 0.2,
    this.expandContent = true,
  }) : super(key: key);

  final PopUpController controller;
  final Widget child;
  final Widget builder;
  final Color background;
  final double opacity;
  final bool expandContent;
  static const _color = Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.showLoading,
      builder: (context, data, _) {
        if (data) {
          return Stack(
            children: [
              child,
              _builder(),
            ],
          );
        }

        return child;
      },
    );
  }

  Widget _builder() {
    final loading = Container(
      decoration: BoxDecoration(
        color: background.withOpacity(opacity),
      ),
      child: Center(
        child: builder,
      ),
    );

    return expandContent ? SizedBox.expand(child: loading) : loading;
  }
}

class PopUpController {
  final ValueNotifier<bool> _showLoading = ValueNotifier<bool>(false);

  ValueNotifier<bool> get showLoading => _showLoading;

  bool get isLoading {
    return _showLoading.value;
  }

  void show() {
    _showLoading.value = true;
  }

  void close() {
    _showLoading.value = false;
  }

  void dispose() {
    _showLoading.dispose();
  }
}
