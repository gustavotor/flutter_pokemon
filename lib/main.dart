import 'package:flutter/material.dart';
import 'search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Escolha um Pokémon!"),
          centerTitle: true,
          leading: Icon(Icons.bar_chart),
        ),
        body: Search(),
      ),
    );
  }
}