import 'package:flutter/material.dart';
import '../JSON/Messages.dart';
import 'styles.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _registerUser(BuildContext context) {
    Map<String, String> newUser = {
      'nombre': usernameController.text,
      'correo': emailController.text,
      'contraseña': passwordController.text
    };
    postData(newUser, '/register/', null);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Regístrate',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(127, 0, 255, 1), fontSize: 50.0),
            ),
            SizedBox(height: 54.0),
            ElevationTextField(
                labelText: 'Nombre de usuario',
                prefixIcon: Icon(Icons.person),
                controller: usernameController,
                password: false),
            SizedBox(height: 36),
            ElevationTextField(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.mail),
                controller: emailController,
                password: false),
            SizedBox(height: 36),
            ElevationTextField(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
                controller: passwordController,
                password: true),
            SizedBox(height: 36),
            Container(
                width: MediaQuery.of(context).size.height * 0.8,
                child: ElevatedButton(
                    onPressed: () => _registerUser(context),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Registrarse',
                            style: TextStyle(color: Colors.white))),
                    style: ElevatedButton.styleFrom(
                      elevation: 8.0,
                      backgroundColor: Color.fromRGBO(127, 0, 255, 1),
                    )))
          ],
        ),
      ),
    );
  }
}
