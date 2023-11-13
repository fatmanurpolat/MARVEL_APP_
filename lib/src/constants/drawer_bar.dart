import 'package:flutter/material.dart';
import 'package:staj_projectt/src/features/auth/login/login_view_model.dart';
import 'package:staj_projectt/src/features/home/presentation/home_screen.dart';

class DrawerBar extends StatelessWidget {
  LoginViewModel _loginController = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Image.asset('assets/marvel_logoo.png')),
             
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ElevatedButton(
                    child: Icon(Icons.logout),
                    onPressed: () {
                      _loginController.signOut(context);
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }
}
