import 'package:flutter/material.dart';
import 'package:toko_klontong_gema/features/auth/pages/login_page.dart';
import 'package:toko_klontong_gema/features/product/domain/models/product_crud_model.dart';
import 'package:toko_klontong_gema/features/product/pages/entry_point.dart';
import 'package:toko_klontong_gema/features/product/pages/product_details_page.dart';
import 'package:toko_klontong_gema/features/splash/pages/splashscreen.dart';

class RouteManager {
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String productDetails = '/productDetails';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));

      case login:
        return MaterialPageRoute(builder: ((context) => const LoginPage()));

      case main:
        return MaterialPageRoute(builder: ((context) => const EntryPoint()));

      case productDetails:
        if (args is ProductCrudModel) {
          return MaterialPageRoute(
              builder: ((context) => ProductDetailsPage(
                    data: args,
                  )));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error Routes.'),
        ),
      );
    });
  }
}
