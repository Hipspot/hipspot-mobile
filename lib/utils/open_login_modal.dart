import 'package:flutter/material.dart';
import 'package:hipspot/component/login.dart';

void openLoginModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Login();
    },
  );
}
