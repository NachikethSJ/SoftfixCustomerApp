import 'package:flutter/material.dart';

loading(BuildContext context, Function() provider) {
  provider();
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
}
