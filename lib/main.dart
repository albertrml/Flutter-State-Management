import 'package:flutter/material.dart';
import 'package:flutter_state_management/main/route/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      color: Colors.deepPurple,
      routerConfig: router,
    );
  }
}
