import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Progress extends StatelessWidget {
  final Color color;
  final bool center;
  const Progress({
    super.key,
    this.color = primaryColor,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return center
        ? Center(
            child: CircularProgressIndicator(color: color),
          )
        : CircularProgressIndicator(color: color);
  }
}
