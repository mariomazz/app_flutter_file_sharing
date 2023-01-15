import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double height;
  final Color color;
  const Separator({
    Key? key,
    this.height = 5,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          color: color,
          constraints: constraints,
          width: constraints.maxWidth,
          height: height,
        );
      },
    );
  }
}
