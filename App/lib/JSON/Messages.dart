import 'package:http/http.dart' as http;
import 'dart:convert';

String server = '192.168.0.6:8000';

Future<Map<String, dynamic>> postData(
    Map<String, dynamic> mensaje, String path, String? token) async {
  try {
    Uri url = Uri.http(server, path);
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = "Bearer $token";
    final encoding = Encoding.getByName('utf-8');
    var response = await http.post(url,
        headers: headers, body: jsonEncode(mensaje), encoding: encoding);

    if (response.statusCode == 200) {
      print('Mensaje enviado exitosamente');
      print('Respuesta del servidor: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print(
          'Error al enviar mensaje. Código de estado: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      return jsonDecode(response.body);
    }
  } catch (e) {
    print('Error: $e');
    return {'Error': '$e'};
  }
}

Future<Map<String, dynamic>> getData(String path, String token) async {
  try {
    Uri url = Uri.http(server, path);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('Solicitud GET exitosa');
      print('Respuesta del servidor: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print(
          'Error al realizar la solicitud GET. Código de estado: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      return {'Error': 'Error en la solicitud GET'};
    }
  } catch (e) {
    print('Error: $e');
    return {'Error': '$e'};
  }
}
