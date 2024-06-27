import 'package:flutter/material.dart';
import 'package:teste_pratico/views/login/loginview.dart';

void main() {
  runApp(const MyApp());
}

//Inicialização do aplicativo!

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Prático',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const LoginView(),
    );
  }
}


