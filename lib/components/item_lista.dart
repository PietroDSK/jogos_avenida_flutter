import 'package:flutter/material.dart';
import 'package:jogos_avenida/classes/game.dart';
import 'package:intl/intl.dart';
import 'package:jogos_avenida/components/games_detalhe_page.dart';
import 'package:jogos_avenida/classes/usuario.dart';

class ItemLista extends StatelessWidget {
  final Jogo jogo;
  final Usuario usuario;

  ItemLista(this.jogo, this.usuario);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(jogo.foto),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 0),
                      child: Text(jogo.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 0),
                      child: Text('Plataformas: ' + jogo.plataforma),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 0),
                      child: Text('Nota: ' + jogo.nota.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 12),
                      child: Text(
                          'Preço ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(jogo.valor)}'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              JogoDetalhePage(jogo, usuario)),
                    );
                  },
                  child: Text(
                    ' Detalhes ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
