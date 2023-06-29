// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumericPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  NumericPad({required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.canvasColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(context, 1),
                buildNumber(context, 2),
                buildNumber(context, 3),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(context, 4),
                buildNumber(context, 5),
                buildNumber(context, 6),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(context, 7),
                buildNumber(context, 8),
                buildNumber(context, 9),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildEmptySpace(),
                buildNumber(context, 0),
                buildBackspace(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumber(BuildContext context, int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNumberSelected(number);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.canvasColor,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: context.theme.shadowColor,
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  // color: Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNumberSelected(-1);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.canvasColor,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: context.theme.shadowColor,
                  blurRadius: 20.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.backspace,
                size: 28,
                // color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return Expanded(
      child: Container(),
    );
  }
}
