import 'package:go_router/go_router.dart';

import '../features/detail/presentation/detail_screen.dart';
import '../features/home/presentation/home_screen.dart';

enum AppRoute {
  home,
  detail,
}

final goRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        //  name: AppRoute.home.name,
        builder: (context, state) => HomeScreen()),
    GoRoute(
        path: '/detail',
        //name: AppRoute.detail.name,
        builder: (context, state) {
          // ignore: prefer_typing_uninitialized_variables
          var id = state.queryParams["id"] ?? '/';
          var myInt = int.parse(id);
          return DetailScreen(characterId: myInt);
        }),
  ],
);
