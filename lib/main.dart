import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/authorization_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      home: AuthorizationForm(),
    );
  }
}