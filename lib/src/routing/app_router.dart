// import 'package:go_router/go_router.dart';

// import '../features/detail/presentation/detail_screen.dart';
// import '../features/home/presentation/home_screen.dart';

// final goRouter = GoRouter(
//   routes: [
//     GoRoute(
//         path: '/',
//         //  name: AppRoute.home.name,
//         builder: (context, state) => HomeScreen()),
//     GoRoute(
//         path: '/detail',
//         //name: AppRoute.detail.name,
//         builder: (context, state) {
//           // ignore: prefer_typing_uninitialized_variables
//           var id = state.queryParams["id"] ?? '/';
//           var myInt = int.parse(id);
//           return DetailScreen(characterId: myInt);
//         }),
//   ],
// );

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:staj_projectt/src/features/auth/login/login_view.dart';
import 'package:staj_projectt/src/features/auth/register/register_view.dart';
import 'package:staj_projectt/src/features/detail/presentation/detail_screen.dart';
import 'package:staj_projectt/src/features/home/presentation/home_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const detail = '/detail';
  static const login = '/login';
  static const register = '/register';
static List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
  GetPage(name: home, page: () => HomeScreen()),
  GetPage(name: login, page: () => LoginView()),
  GetPage(name: register, page: () => RegisterView()),
  GetPage(
   name: detail,
page: () {
  try {
    var id = Get.parameters['id'];
    if (id != null && id.isNotEmpty) {
      var myInt = int.parse(id);
      return DetailScreen(characterId: myInt);
    } else {
      // Geçerli bir sayısal ifade yoksa varsayılan bir sayfa veya widget döndür
      return Container(
        child: Text('Geçersiz ID formatı. Lütfen tekrar deneyin.'),
      );
    }
  } catch (e) {
    // Diğer olası hataları konsola yazdır
    print('Hata: $e');
    // Varsayılan bir sayfa veya widget döndür
    return Container(
      child: Text('Bir hata oluştu. Lütfen tekrar deneyin.'),
    );
  }
},

  ),
];

}
