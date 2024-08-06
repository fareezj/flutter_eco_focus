import 'package:eco_focus/features/liveSession/live_session_screen.dart';
import 'package:eco_focus/features/settings/settings_screen.dart';
import 'package:eco_focus/features/startSession/start_session_screen.dart';
import 'package:eco_focus/main_screen.dart';
import 'package:eco_focus/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:eco_focus/features/auth/sign_in_screen.dart';
import 'package:eco_focus/features/auth/sign_up_screen.dart';
import 'package:eco_focus/features/home/home_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/start-session':
        return MaterialPageRoute(builder: (_) => const StartSessionScreen());
      case '/live-session':
        var args = settings.arguments as LiveSessionArguments;
        return MaterialPageRoute(
          builder: (_) => LiveSessionScreen(
            selectedCategory: args.selectedCategory,
            selectedTime: args.selectedFocusTime,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      );
    });
  }
}

class LiveSessionArguments {
  final CategoryModel selectedCategory;
  final String selectedFocusTime;

  LiveSessionArguments(
      {required this.selectedCategory, required this.selectedFocusTime});
}
