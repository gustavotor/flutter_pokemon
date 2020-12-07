// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:projeto_final/Pokemon.dart' as poke;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<poke.Pokemon> resPokemon = List<poke.Pokemon>();
  bool isLoading = false;

  // _getMovies(moviesSearched) {
  //   API.getMovies(moviesSearched).then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       movies = list.map((model) => Movie.fromJson(model)).toList();
  //     });
  //   });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getMovies("");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _searchBar(),
              Expanded(
                flex: 1,
                child: _mainData(),
              )
            ],
          ),
        ));
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search your Pokémon!",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {},
        textInputAction: TextInputAction.search,
        onSubmitted: (text) {
          print("Searched by: '$text'");
          _fetchPokemon(text);
        },
      ),
    );
  }

  _fetchPokemon(String text) async {
    //setState(() {
    //  isLoading = true;
    //});
    List<poke.Pokemon> tempList = resPokemon;
    poke.Pokemon pokemon = poke.Pokemon();
    final response = await http.get("https://pokeapi.co/api/v2/pokemon/$text");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      pokemon = poke.Pokemon.fromJson(jsonResponse);
      tempList.add(pokemon);
    } else {
      throw Exception("Failed to fetch results for $text.");
    }
    setState(() {
      resPokemon = tempList;
      isLoading = false;
    });
  }

  Widget _mainData() {
    return Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: resPokemon.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(resPokemon[index].name),
                    subtitle: Text("${resPokemon[index].types[0].type.name}"),
                    trailing:
                        Image.network(resPokemon[index].sprites.frontDefault),
                    dense: false,
                    isThreeLine: false,
                    // Icon(Icons.movie),
                  ));
                }));
  }
}
