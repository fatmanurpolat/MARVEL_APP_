import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staj_projectt/src/features/home/presentation/home_screen.dart';
import 'package:staj_projectt/src/routing/app_router.dart';

class LoginViewModel {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  Future<void> checkCurrentUser(context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => HomeScreen()),
      );
    }
  }

  Future<void> login(BuildContext context) async {
    String email = emailTextController.text.trim();
    String password = passwordTextController.text.trim();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Giriş başarılı, ana sayfaya yönlendirin
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => HomeScreen()),
        );
      } else {
        // Kullanıcı bilgileri hatalı
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Kullanıcı adı veya şifre hatalı.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Kapat'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Giriş sırasında bir hata oluştu
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Giriş sırasında bir hata oluştu: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Kapat'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Kullanıcı başarıyla çıkış yaptıktan sonra yapılması gereken işlemleri buraya ekleyebilirsiniz.
      // Örneğin, farklı bir sayfaya yönlendirme gibi.
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      print('Logout Error: $e');
    }
  }
  // goToRegisterPage(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => RegisterView(),
  //     ),
  //   );
  // }
}
