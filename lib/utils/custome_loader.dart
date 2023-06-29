
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

BuildContext? _progressContext;

void showProgressbarDialog(BuildContext context, {Color? loaderColor}) {
  if (_progressContext == null) {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (con) {
          _progressContext = con;
          return Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12.withOpacity(0.30)),
              child: Stack(
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpinKitCircle(
                        size: 50,
                        color: Color(0XFF244da0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

void hideProgressDialog() {
  if (_progressContext != null) {
    print("Context Not Null");
    Navigator.pop(_progressContext!);
    _progressContext = null;
  } else {
    print("Context Null");
  }
}
