import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staj_projectt/src/constants/custom_elevated_button.dart';
import 'package:staj_projectt/src/constants/custom_text_field.dart';
import 'package:staj_projectt/src/features/auth/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/marvel_logoo.png',
              width: 200,
            ),
            SizedBox(
              height: 30,
            ),
            //Hello Again!
            Text(
              "Hello There!",
              style: GoogleFonts.bebasNeue(fontSize: 38),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Register below with your details!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            customTextField(
              hintext: 'Email',
              isObsecure: false,
              controller: viewModel.emailTextController,
            ),
            customTextField(
              hintext: 'Password',
              isObsecure: false,
              controller: viewModel.passwordTextController,
            ),
            customTextField(
              hintext: 'Confirm Password',
              isObsecure: false,
              controller: viewModel.confirmTextController,
            ),
            customElevatedButton(
                onPressed: () {
                  viewModel.signUp(context);
                },
                buttonText: 'Regiter'),

            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Do you already have an account?'))
          ],
        ),
      ),
    );
  }
}
