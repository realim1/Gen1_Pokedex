import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_search/material_search.dart';


void main() => 
  runApp(MaterialApp(
  home: MyApp(),
));


class MyApp extends StatefulWidget{
  @override
  PokeDexState createState() => PokeDexState();
}

class Pokemon{
  final String name;
  final String idNum;
  final String url;
  final List type;
  final List weaknesses;
  final double spawnChance;


  Pokemon.fromJsonMap(Map map)
  : name = map['name'],
    idNum = map['num'],
    url = map['img'],
    type = map['type'],
    weaknesses = map['weaknesses'],
    spawnChance = map['spawn_chance'];

}

class PokemonInfoPage extends StatelessWidget{
  @override
  PokemonInfoPage(this.pokemon);
  final Pokemon pokemon;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:Text(pokemon.name)
        ),
    );
  }


}


class PokeDexState extends State<MyApp>{

StreamController<Pokemon> streamController;
TextEditingController controller = new TextEditingController();
List<Pokemon> list = [];
List<Pokemon> searchResults = [];
  
onSearchTextChanged(String text) async{
  searchResults.clear();
  if(text.isEmpty){
    setState(() {
          return;
    });
  }
  
  list.forEach((pokemonItem){
    if(pokemonItem.name.contains(text) || pokemonItem.idNum.contains(text))
      searchResults.add(pokemonItem);
  });

  setState(() {
      
    });
}


 load(StreamController sc) async{
   //String url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
   String url = "https://raw.githubusercontent.com/realim1/pokemonGo-json/master/PokemonGo.json?token=AiSE9sALOVrNB1Yqu5EgEW9vCDjcdclwks5bNtznwA%3D%3D";
   var client = http.Client();

   var req = http.Request('get', Uri.parse(url));

   var streamedRes = await client.send(req);

   streamedRes.stream
    .transform(UTF8.decoder)
    .transform(json.decoder)
    .expand((e) => e)
    .map((map) => Pokemon.fromJsonMap(map))
    .pipe(streamController);
    
 }

  @override
  void dispose(){
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  //Calls our getData function on initial start of application
  @override
  void initState(){
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) =>
      setState(() => list.add(p)
      )); 

    load(streamController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: null,
          )
        ],
        
      ),
      body: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                    ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: (){
                      controller.clear();
                      onSearchTextChanged('');
                     },
                    
                  ),
                  )
                ),
              ),
            Expanded(
              child: searchResults.length != 0 || controller.text.isNotEmpty
              ? ListView.builder(
                itemBuilder: (BuildContext context, int index) => _createSearchResultList(index),
              )
              : ListView.builder(
                itemBuilder: (BuildContext context, int index) => _createWholeList(index),
              ) 
            )
          ]
      )
    );
  }


  Widget _createWholeList(int index){
    if(index >= list.length){
      return null;
    }

    return GestureDetector(
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new PokemonInfoPage(
                list[index]
              ),
            ));
          },
          child:Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(list[index].name, style: TextStyle(fontSize: 20.0),)
                            ) 
                          ),
                        
                        Container(
                          child: Center(
                            child: Text('#'+list[index].idNum, style: TextStyle(fontSize: 18.0),)
                            ) 
                          ),

                        Container(
                          child: Center(
                            child: Image.network(list[index].url, )
                            ) 
                          ),
                        
                      ],
                    )
                  )
                ],
              )
            )
            ));
  }

  Widget _createSearchResultList(int index){
    if(index >= searchResults.length){
      return null;
    }

    return GestureDetector(
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new PokemonInfoPage(
                searchResults[index]
              ),
            ));
          },
          child:Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(searchResults[index].name, style: TextStyle(fontSize: 20.0),)
                            ) 
                          ),
                        
                        Container(
                          child: Center(
                            child: Text('#'+searchResults[index].idNum, style: TextStyle(fontSize: 18.0),)
                            ) 
                          ),

                        Container(
                          child: Center(
                            child: Image.network(searchResults[index].url, )
                            ) 
                          ),
                        
                      ],
                    )
                  )
                ],
              )
            )
            ));
  }




}