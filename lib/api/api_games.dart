import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jogos_avenida/classes/game.dart';

class ApiJogos {
  final url =
      'https://api.sheety.co/5b8282a5dd86be0cdc191cb58ab400e8/jogosAvenida/games';

  // getCarros() async {
  //   var response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   print({json.decode(response.body)['carros']});
  // }

  getJogos() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['games'];
      List<Jogo> jogos =
          lista.map<Jogo>((jogo) => Jogo.fromJson(jogo)).toList();
//      print(carros);
      return jogos;
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }

  getJogosPesquisa(String palavra) async {
    var response = await http.get(url + '?filter[nome]=' + palavra);

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['games'];
      List<Jogo> jogos =
          lista.map<Jogo>((jogo) => Jogo.fromJson(jogo)).toList();
//      print(carros);
      return jogos;
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
