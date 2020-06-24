import 'package:dexyago/pokemon.dart';
import 'package:dexyago/pokemondetail.dart';
import 'package:flutter/material.dart';
//permite usar a internet e fazer uma requisição que n precisa travar o programa
import 'package:http/http.dart' as http;
import 'dart:convert';



void main()=> runApp(
  MaterialApp(
    title: "DexYago",
    home:HomePage(),
    debugShowCheckedModeBanner: false,
  ));

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fetchData();
  }

  //metodo assincrono
  fetchData() async{
    var res = await http.get(url);
    var decodedjson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedjson);
    print(pokeHub.toJson());
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //configuração AppBar
      appBar: AppBar(
        title: Text("DexYago - Primeira Geração"),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),

      //conf body
      body: pokeHub == null?Center(
        child: CircularProgressIndicator(),
      ):
      GridView.count(crossAxisCount: 2,
      children: pokeHub.pokemon.map(
          (poke)=> Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>PokeDetail(
                    pokemon: poke,
                  )
                ));
              },
              child: Hero(
                tag: poke.img,
                child: Card(
                  elevation: 3.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(poke.img)),
                        ),
                      ),
                      Text(poke.name,
                      style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
      ),

      //conf drawer
      drawer: Drawer(

      ),

      //conf Floating button
      floatingActionButton: FloatingActionButton(onPressed: (){},
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.refresh),
      ),
    );
  }


}




