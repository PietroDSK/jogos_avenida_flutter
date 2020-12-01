import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:jogos_avenida/classes/usuario.dart';

class LoginBloc extends BlocBase {
  final _usuarioController = StreamController<Usuario>();
  Stream<Usuario> get outUsuario => _usuarioController.stream;

  void loginUsuario(usuario) {
    _usuarioController.sink.add(usuario);
  }

  @override
  void dispose() {
    _usuarioController.close();
  }
}
