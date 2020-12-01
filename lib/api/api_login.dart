import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jogos_avenida/classes/usuario.dart';

class ApiLogin {
  final url =
      'https://api.sheety.co/5b8282a5dd86be0cdc191cb58ab400e8/jogosAvenida/usuarios';

  getLoginUsuario(String email, String senha) async {
    var response =
        await http.get(url + '?filter[email]=${email}&filter[senha]=${senha}');

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['usuarios'];

      if (lista.length == 1) {
        //print(lista[0]);
        //print(lista[0]['nome']);
        return Usuario(lista[0]['id'], lista[0]['nome'], lista[0]['email']);
      } else {
        return null;
      }
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
