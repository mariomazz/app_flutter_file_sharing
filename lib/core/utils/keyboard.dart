import 'package:flutter/material.dart';

class Keyboard {
  static FocusNode get mainFocusNode => _mainFocusManager;
  static final _mainFocusManager = FocusNode();
  void unfocus(FocusNode node) {
    if (node.hasFocus) {
      node.unfocus();
    }
  }

  void changeFocus(FocusNode node) {
    if (node.hasFocus) {
      node.unfocus();
    } else {
      node.requestFocus();
    }
  }
}
