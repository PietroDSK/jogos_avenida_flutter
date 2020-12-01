import 'package:flutter/material.dart';
import 'package:jogos_avenida/api/api_comentario.dart';
import 'package:jogos_avenida/api/api_comentario.dart';
import 'package:jogos_avenida/classes/game.dart';
import 'package:jogos_avenida/classes/usuario.dart';

class JogoDetalhePage extends StatefulWidget {
  final Jogo jogo;
  final Usuario usuario;

  JogoDetalhePage(this.jogo, this.usuario);

  @override
  _JogoDetalhePageState createState() => _JogoDetalhePageState();
}

class _JogoDetalhePageState extends State<JogoDetalhePage> {
  var _edComentario = TextEditingController();
  String _mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Detalhes do Jogo'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(widget.jogo.foto),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.usuario == null
                ? "Você deve se logar para fazer um comentario"
                : "Faça um Comentario, ${widget.usuario.nome}!",
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          _formComentario(),
        ],
      ),
    );
  }

  _formComentario() {
    if (widget.usuario == null) {
      return Center(
        child: Text("Espero que goste..."),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edComentario,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: 'Seu comentario no jogo ${widget.jogo.nome}',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FlatButton(
              onPressed: () async {
                await _enviarComentario();
              },
              child: Text(
                ' Enviar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _mensagem,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  _enviarComentario() async {
    if (_edComentario.text == '') {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Atenção:"),
          content: new Text("Por favor, informe seu comentário!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    ApiComentarios apiComentarios = ApiComentarios();
    final comentarioId = await apiComentarios.saveComentario(
        widget.jogo, widget.usuario, _edComentario.text);

    if (comentarioId > 0) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Cometário Cadastrado com Sucesso"),
          content: new Text(
              "Muito obrigado por seu comentário. Seu comentário: ${comentarioId}"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } else {
      print('Erro de acesso ao WebService...');
    }
  }
}
