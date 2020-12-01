import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:jogos_avenida/api/api_games.dart';
import 'package:jogos_avenida/classes/game.dart';

class JogosBloc extends BlocBase {
  final _jogosController = StreamController<List<Jogo>>();
  Stream<List<Jogo>> get outJogos => _jogosController.stream;

  ApiJogos apiJogos = ApiJogos();

  void buscaJogos() async {
    final jogos = await apiJogos.getJogos();
    _jogosController.sink.add(jogos);
  }

  void buscaJogosPesquisa(String palavra) async {
    _jogosController.sink.add(null);
    final jogos = await apiJogos.getJogosPesquisa(palavra);
    _jogosController.sink.add(jogos);
  }

  @override
  void dispose() {
    _jogosController.close();
  }
}
