import 'package:flutter/material.dart';
import 'package:mind/screens/screens.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PlayerScreen.routeName:
        return MaterialPageRoute(builder: (_) => PlayerScreen());
      /*case ServiceScreen.routeName:
        Service service = settings.arguments as Service;
        return MaterialPageRoute(
          builder: (_) => ServiceScreen(
            service: service,
          ),
        );*/
      default:
        return MaterialPageRoute(builder: (_) => PlayerScreen());
    }
  }
}
