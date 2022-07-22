import 'package:flutter/material.dart';

class IfElseWidget extends StatelessWidget {
  final Widget ifWidget;
  final Widget elseWidget;
  final bool condition;

  const IfElseWidget({
    Key? key,
    required this.ifWidget,
    required this.elseWidget,
    required this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return ifWidget;
    } else {
      return elseWidget;
    }
  }
}
