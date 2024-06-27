import 'package:flutter/material.dart';
import 'package:teste_pratico/views/home/Productview.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Função que verifica os campos de email e senha.
  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _emailError = _validateEmail(email) ? null : 'Email inválido';
      _passwordError = _validatePassword(password);
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductListScreen()),
      );
    }
  }

  bool _validateEmail(String email) {
    String validateEmail = r'^[^@]+@[^@]+\.[^@]+';
    return RegExp(validateEmail).hasMatch(email);
  }

  String? _validatePassword(String password) {
    if (password.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    String validatePassword = r'^(?=.*[A-Z])|(?=.*[!@#\$&*~])';
    if (!RegExp(validatePassword).hasMatch(password)) {
      return 'Senha deve conter uma letra maiúscula ou um caractere especial';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(15, 65, 123, 1),
              Color.fromRGBO(86, 142, 173, 1),
            ],
            stops: [0.1, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/images/sifat_logo.jfif"),
                  ),
                  const SizedBox(height: 110),
                  SizedBox(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: _emailError != null ? Colors.red : Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: _emailError != null ? Colors.red : Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Email',
                          ),
                        ),
                        if (_emailError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 15),
                            child: Text(
                              _emailError!,
                              style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: _passwordError != null ? Colors.red : Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: _passwordError != null ? Colors.red : Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Senha',
                            counterText: '',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        if (_passwordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 15),
                            child: Text(
                              _passwordError!,
                              style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(17, 61, 116, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
