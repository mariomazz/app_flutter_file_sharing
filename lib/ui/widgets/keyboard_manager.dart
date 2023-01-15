import 'package:flutter/material.dart';
import '../../core/utils/keyboard.dart';

class KeyboardManager extends StatefulWidget {
  final FocusNode? node;
  final Widget Function(FocusNode focus, void Function() startKeyboard) builder;
  const KeyboardManager({
    Key? key,
    this.node,
    required this.builder,
  }) : super(key: key);

  @override
  State<KeyboardManager> createState() => _KeyboardManagerState();
}

class _KeyboardManagerState extends State<KeyboardManager> {
  FocusNode? focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = widget.node ?? Keyboard.mainFocusNode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Keyboard().unfocus(focusNode ?? Keyboard.mainFocusNode),
      child: widget.builder.call(focusNode ?? Keyboard.mainFocusNode,
          (focusNode ?? Keyboard.mainFocusNode).requestFocus),
    );
  }
}
