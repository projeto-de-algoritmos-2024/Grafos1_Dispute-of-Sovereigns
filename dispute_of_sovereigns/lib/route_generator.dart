import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/main.dart';
import 'package:dispute_of_sovereigns/pages/inicio.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Home());

      case "/home":
        return MaterialPageRoute(builder: (_) => const Home());

      case "/jogo":
        return MaterialPageRoute(builder: (_) => const Jogo());

      default:
        return _routeError();
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: AppColors.dark,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(_);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.light,
              size: 28,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Tela não encontrada!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.light,
            ),
          ),
          backgroundColor: AppColors.darkd,
        ),
        body: const Center(
          child: Text(
            "TELA NÃO ENCONTRADA",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.light,
            ),
          ),
        ),
      );
    });
  }
}
