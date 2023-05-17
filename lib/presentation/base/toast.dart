

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorToastbar(String error) {
  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 4,
      backgroundColor: Color.fromARGB(255, 94, 70, 68),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

