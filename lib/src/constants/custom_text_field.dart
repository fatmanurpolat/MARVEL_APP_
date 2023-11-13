import 'package:flutter/material.dart';

Widget customTextField(
        {required String hintext,
        required bool isObsecure,
        required TextEditingController controller,
        TextInputType? inputType}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          
          controller: controller,
          keyboardType: inputType ?? TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hintext,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8),
          ),
          obscureText: isObsecure,
        ),
      ),
    );
