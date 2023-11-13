import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staj_projectt/src/constants/custom_elevated_button.dart';
import 'package:staj_projectt/src/constants/custom_text_field.dart';

import 'package:staj_projectt/src/features/auth/login/login_view_model.dart';
import 'package:staj_projectt/src/features/auth/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.checkCurrentUser(context);
    }); // viewModel.loc
  }

  LoginViewModel viewModel = LoginViewModel(); //nesne oluşturduk
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/marvel_logoo.png',
                  width: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hello Advantures!",
                  style: GoogleFonts.bebasNeue(fontSize: 38),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome back, you 've been missed!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  hintext: 'Email',
                  isObsecure: false,
                  controller: viewModel.emailTextController,
                ),
                customTextField(
                  hintext: 'Username',
                  isObsecure: true,
                  controller: viewModel.passwordTextController,
                ),
                customElevatedButton(onPressed: (){ viewModel.login(context);}, buttonText: 'Giriş',),
                
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterView()));
                    },
                    child: Text("Don't have an account?"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
