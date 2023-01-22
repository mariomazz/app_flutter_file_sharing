import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle primaryTextStyle = TextStyle(
  color: textPrimaryColor,
);

const TextStyle primaryTextStyleBold = TextStyle(
  color: textPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 24,
);

Widget iconPrimary(IconData icon) {
  return Icon(
    icon,
    color: iconPrimaryColor,
  );
}
