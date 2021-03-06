import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:jogos_avenida/api/api_login.dart';
//import 'package:revenda_herbie/cliente.dart';
import 'package:jogos_avenida/blocs/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = BlocProvider.getBloc<LoginBloc>();

  var _edEmail = TextEditingController();
  var _edSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _quadroSuperior(context),
          _camposForm(context),
        ],
      ),
    );
  }

  _quadroSuperior(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final quadro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(2,0,36,1),
          Color.fromRGBO(61,0,119,1),
        ]),
      ),
    );

    final balao = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.10),
      ),
    );

    return Stack(
      children: <Widget>[
        quadro,
        Positioned(child: balao, top: 120, left: 30),
        Positioned(child: balao, top: 50, left: 250),
        Positioned(child: balao, top: 150, right: -25),
        Positioned(child: balao, top: 200, left: 150),
        Positioned(child: balao, top: 10, left: 40),
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/jogos.png',
                fit: BoxFit.contain,
                height: 42,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Jogos Avenida',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _camposForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Login do Usuário',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                _campoEmail(),
                _campoSenha(),
                _botaoAcesso(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _campoEmail() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: TextField(
        controller: _edEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(
              Icons.alternate_email,
              color: Colors.black,
            ),
            labelText: 'E-mail:'),
      ),
    );
  }

  _campoSenha() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: TextField(
        controller: _edSenha,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock_open,
            color: Colors.black,
          ),
          labelText: 'Senha:',
        ),
      ),
    );
  }

  RaisedButton _botaoAcesso() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
        child: Text('Login', style: TextStyle(fontSize: 18, fontFamily: 'ShareMonoTech', fontWeight: FontWeight.bold),),
      ),
      onPressed: () async {
        await _verificaLogin();
      },
    );
  }

  Future<void> _verificaLogin() async {
    if (_edEmail.text == '' || _edSenha.text == '') {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Atenção:"),
          content:
              new Text("Preencha todos os campos ou clique no botão voltar"),
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

    ApiLogin apiLogin = ApiLogin();
    final usuario =
        await apiLogin.getLoginUsuario(_edEmail.text, _edSenha.text);

    if (usuario == null) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Login Inválido"),
          content: new Text(
              "Informe novamente seus dados, ou clique no botão voltar"),
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
      // Adiciona ao Stream o cliente logado
      _bloc.loginUsuario(usuario);

      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Login Efetuado com Sucesso!!"),
          content: new Text("Agora você pode fazer comentarios nos jogos!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }
}
