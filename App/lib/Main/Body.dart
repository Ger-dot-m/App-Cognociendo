import 'package:flutter/material.dart';
import 'Option.dart';
import '../Pet/Pet.dart';
import '../JSON/Messages.dart';

class Body extends StatefulWidget {
  final String acces_token;
  Body(this.acces_token);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Map<String, dynamic>>? _entries;

  @override
  void initState() {
    super.initState();
    _entries = get_entries();
    print(_entries);
  }

  Future<Map<String, dynamic>> get_entries() {
    var response = getData('/read_entries/', widget.acces_token);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Pet(widget.acces_token),
                    Expanded(
                      child: GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: (1 / .5),
                        children: <Widget>[
                          OptionItem('Opción 1', 0, widget.acces_token),
                          OptionItem('Opción 2', 1, widget.acces_token),
                          OptionItem('Opción 3', 2, widget.acces_token),
                          OptionItem('Opción 4', 3, widget.acces_token),
                          OptionItem('Opción 5', 4, widget.acces_token),
                          OptionItem('Opción 6', 5, widget.acces_token),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.32,
                  bottom: MediaQuery.of(context).size.height * 0.52,
                  left: MediaQuery.of(context).size.height * 0.3,
                  right: MediaQuery.of(context).size.height * 0.3,
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(20.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Gato'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
