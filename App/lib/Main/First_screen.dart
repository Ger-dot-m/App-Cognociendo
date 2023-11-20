import 'package:flutter/material.dart';
import 'Body.dart';

class Inicio extends StatefulWidget {
  final String acces_token;
  Inicio(this.acces_token);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(widget.acces_token));
  }
}
