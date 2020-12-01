import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:jogos_avenida/blocs/games_bloc.dart';
import 'package:jogos_avenida/blocs/login_bloc.dart';
import 'package:jogos_avenida/components/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc((i) => JogosBloc()),
          Bloc((i) => LoginBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: HomePage(),
        ),);
  }
}
