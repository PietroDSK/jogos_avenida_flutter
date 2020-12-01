import 'package:date_format/date_format.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiComentarios {
  final url =
      'https://api.sheety.co/5b8282a5dd86be0cdc191cb58ab400e8/jogosAvenida/comentarios';

  saveComentario(jogo, usuario, comentario) async {
    var reg = {
      "proposta": {
        "jogoId": jogo.id,
        "usuarioId": usuario.id,
        "comentario": comentario,
        "data": formatDate(
            DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
      }
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
      body: jsonEncode(reg),
    );

    if (response.statusCode == 200) {
      var retorno = jsonDecode(response.body)['comentario'];
      return retorno['id'];
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
