import 'package:flutter/material.dart';

class AppCommonCommands {
  static void dismissKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
