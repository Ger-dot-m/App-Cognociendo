import 'package:flutter/material.dart';

class Pet extends StatelessWidget {
  final String acces_token;
  Pet(this.acces_token);

  Future<void> _taks() async {
    print('Datos cargados');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(127, 0, 255, 1),
        ),
        child: Image.asset(
          'assets/images/cat3.gif',
          fit: BoxFit.cover,
        ));
  }
}
