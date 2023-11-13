import 'package:flutter/material.dart';

Widget customElevatedButton(
        {required Function() onPressed,
        required String buttonText,
        Color? buttonColor}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: buttonColor ?? Colors.red.shade900,
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
