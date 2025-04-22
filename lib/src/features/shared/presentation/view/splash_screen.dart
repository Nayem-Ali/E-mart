import 'package:e_mart/src/core/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        context.replaceNamed(RoutesName.home);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("E-Mart", style: Theme.of(context).textTheme.displayMedium)),
    );
  }
}
