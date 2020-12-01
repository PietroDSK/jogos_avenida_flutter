import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:jogos_avenida/classes/game.dart';
import 'package:jogos_avenida/blocs/games_bloc.dart';
import 'package:jogos_avenida/classes/usuario.dart';
import 'package:jogos_avenida/components/item_lista.dart';
import 'package:jogos_avenida/blocs/login_bloc.dart';
import 'package:jogos_avenida/components/login_page.dart';
import 'package:jogos_avenida/components/menu_pesquisa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = BlocProvider.getBloc<JogosBloc>();
  final _blocLogin = BlocProvider.getBloc<LoginBloc>();
  Usuario _pessoaLogada;

  @override
  void initState() {
    super.initState();
    _blocLogin.outUsuario.listen((dado) {
      setState(() {
        _pessoaLogada = dado;
      });
//      print("Logado: " + _pessoaLogada.nome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/jogos.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text('Avenida', style: TextStyle(fontFamily: 'ShareTechMono'),),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            color: _pessoaLogada == null
                ? Colors.red
                : Colors.blue,
            icon: _pessoaLogada == null
                ? Icon(Icons.login)
                : Icon(Icons.verified_user),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(Icons.all_inclusive),
            onPressed: () {
              _body(context);
              //  _bloc.buscaJogos();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String pesq = await showSearch(
                context: context,
                delegate: MenuPesquisa(),
              );
              // print(pesq);
              if (pesq != null) {
                _bloc.buscaJogosPesquisa(pesq);
              } else {
                _bloc.buscaJogos();
              }
            },
          ),
        ],
      ),
      body: _body(context),
    );
  }

  _body(context) {
    _bloc.buscaJogos();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<Jogo>>(
            stream: _bloc.outJogos,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao acessar WebService',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    'Não há jogos com este nome!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return ItemLista(snapshot.data[index], _pessoaLogada);
                },
                itemCount: snapshot.data.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
