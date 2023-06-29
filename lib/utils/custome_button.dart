import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key,required this.child, required this.onPressed,required this.color}) : super(key: key);
  var child;
  var onPressed;
  var color;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(10),
      color: color,
      child: child,
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(12),
    );
  }
}
