import 'package:e_mart/src/core/app/app.dart';
import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/core/global_variable/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupService();
  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
