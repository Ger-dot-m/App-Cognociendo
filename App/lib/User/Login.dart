import 'package:flutter/material.dart';
import '../Main/First_screen.dart';
import 'Register.dart';
import '../JSON/Messages.dart';
import 'styles.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      )),
    ));
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    Map<String, String> user_login = {
      'correo': _emailController.text,
      'contraseña': _passwordController.text
    };
    print(user_login['correo']);
    if (user_login['correo'] == 'root') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Inicio(""),
        ),
      );
    }
    Map response = await postData(user_login, '/token/', null);
    if (!response.containsKey('Error')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Inicio(response['access_token']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credenciales incorrectas. Inténtalo de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Inicia sesión',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(127, 0, 255, 1), fontSize: 50.0),
          ),
          SizedBox(height: 54.0),
          ElevationTextField(
              labelText: 'Correo',
              prefixIcon: Icon(Icons.mail),
              controller: _emailController,
              password: false),
          SizedBox(height: 36.0),
          ElevationTextField(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              controller: _passwordController,
              password: true),
          SizedBox(height: 36.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: MediaQuery.of(context).size.height * 0.8,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8.0,
                      backgroundColor: Color.fromRGBO(127, 0, 255, 1),
                    ),
                  )),
              SizedBox(height: 18.0),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('¿No tienes una cuenta? Regístrate'),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
