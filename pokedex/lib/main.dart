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
  final String height;
  final String weight;
  final List type;
  final List weaknesses;
  //final double spawnChance;


  Pokemon.fromJsonMap(Map map)
  : name = map['name'],
    idNum = map['num'],
    url = map['img'],
    type = map['type'],
    height = map['height'],
    weight = map['weight'],
    weaknesses = map['weaknesses'];
    //spawnChance = map['spawn_chance'];

}

class PokemonInfoPage extends StatelessWidget{
  

  Color getColor(String type){
    if(type == 'Fire')
      return Color(0xFFED813A);
    else if(type == 'Grass')
      return Color(0xFF7BC658);
    else if(type == 'Water')
      return Color(0xFF6B91EA);
    else if(type == 'Fighting')
      return Color(0xFFC12E30);
    else if(type == 'Flying')
      return Color(0xFFAA91EE);
    else if(type == 'Normal')
      return Color(0xFFA9A678);
    else if(type == 'Poison')
      return Color(0xFF9E45A2);
    else if(type == 'Electric')
      return Color(0xFFF6CB3E);
    else if(type == 'Ground')
      return Color(0xFFDFBA67);
    else if(type == 'Psychic')
      return Color(0xFFFB5B8B);
    else if(type == 'Rock')
      return Color(0xFFB5A040);
    else if(type == 'Ice')
      return Color(0xFF9ED6D3);
    else if(type == 'Bug')
      return Color(0xFFA7B440);
    else if(type == 'Dragon')
      return Color(0xFF7143F4);
    else if(type == 'Ghost')
      return Color(0xFF6E599C);
    else if(type == 'Dark')
      return Color(0xFF6E584A);
    else if(type == 'Steel')
      return Color(0xFFB7B9D1);
    else
      return Color(0xFFEA9BAE);
  }

  Image getImage(String type){
      if(type == 'Fire')
      return Image.network('http://www.top4themes.com/data/out/49/5744584-fire-pokemon-wallpapers.png');
    else if(type == 'Grass')
      return Image.network('https://img00.deviantart.net/f80b/i/2014/042/7/d/grass_pokemon_energy_wallpaper_by_elbarnzo-d755hbj.png');
    else if(type == 'Water')
      return Image.network('https://img00.deviantart.net/8a84/i/2014/042/8/6/water_pokemon_energy_wallpaper_by_elbarnzo-d75ebft.png');
    else if(type == 'Fighting')
      return Image.network('https://img00.deviantart.net/9d02/i/2014/042/0/9/fighting_pokemon_energy_wallpaper_by_elbarnzo-d74vo4c.png');
    else if(type == 'Flying')
      return Image.network('https://pre00.deviantart.net/b623/th/pre/f/2016/317/f/7/flying_type_pokemon_energy_by_elbarnzo-daoas8t.png');
    else if(type == 'Normal')
      return Image.network('https://img00.deviantart.net/cb67/i/2014/031/0/b/colorless_pokemon_energy_wallpaper_by_elbarnzo-d74i220.png');
    else if(type == 'Poison')
      return Image.network('https://pre00.deviantart.net/7ce7/th/pre/f/2017/209/f/b/poison_type_pokemon_wallpaper_by_elbarnzo-dbi2b02.png');
    else if(type == 'Electric')
      return Image.network('https://t00.deviantart.net/yBj5j6qmTCOUIvWofWLf97Pii9Y=/fit-in/700x350/filters:fixed_height(100,100):origin()/pre00/23b1/th/pre/i/2014/042/3/2/electric_pokemon_energy_wallpaper_by_elbarnzo-d74n7g8.png');
    else if(type == 'Ground')
      return Image.network('https://pre00.deviantart.net/5049/th/pre/f/2017/209/d/c/ground_type_pokemon_wallpaper_by_elbarnzo-dbi2ame.png');
    else if(type == 'Psychic')
      return Image.network('https://img00.deviantart.net/3d74/i/2014/042/b/5/physic_pokemon_energy_wallpaper_by_elbarnzo-d759r4f.png');
    else if(type == 'Rock')
      return Image.network('https://pre00.deviantart.net/5117/th/pre/f/2017/209/9/6/rock_type_pokemon_wallpaper_by_elbarnzo-dbi2b77.png');
    else if(type == 'Ice')
      return Image.network('https://pre00.deviantart.net/a5f3/th/pre/f/2017/209/0/f/ice_type_pokemon_wallpaper_by_elbarnzo-dbi2axg.png');
    else if(type == 'Bug')
      return Image.network('https://pre00.deviantart.net/848d/th/pre/f/2016/275/6/7/bug_type_pokemon_wallpaper_by_elbarnzo-dajncbl.png');
    else if(type == 'Dragon')
      return Image.network('https://pre00.deviantart.net/206b/th/pre/f/2016/279/4/b/dragon_type_pokemon_wallpaper_by_elbarnzo-dak4w59.png');
    else if(type == 'Ghost')
      return Image.network('https://img00.deviantart.net/c868/i/2016/326/b/8/ghost_type_pokemon_wallpaper_by_elbarnzo-dapamlc.png');
    else if(type == 'Dark')
      return Image.network('https://pre00.deviantart.net/9c3b/th/pre/f/2016/277/b/2/dark_type_pokemon_wallpaper_by_elbarnzo-dajx3sf.png');
    else if(type == 'Steel')
      return Image.network('https://pre00.deviantart.net/cb69/th/pre/f/2017/209/a/9/steel_type_pokemon_wallpaper_by_elbarnzo-dbi2bbj.png');
    else
      return Image.network('https://pre00.deviantart.net/5aaa/th/pre/f/2016/317/d/b/fairy_type_pokemon_wallpaper_by_elbarnzo-daoarj9.png');
  }
  
  @override
  PokemonInfoPage(this.pokemon);
  final Pokemon pokemon;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(pokemon.type[0]),
        title:Text(pokemon.name)
        ),
      body: ListView(
        children: <Widget>[

          Stack(children: <Widget>[

            Container(
              child: getImage(pokemon.type[0])
            ),
            Container(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Image.network(pokemon.url),  
              )
            ),
    
          ],),
          Container(
            child: pokemon.type.length > 1 
            ? Row(
              children: <Widget>[
                Container(
                  width: 200.0,
                  child:Chip(
                    backgroundColor: getColor(pokemon.type[0]),
                    label: Center(child:Text(pokemon.type[0])),
                  )
                ),
                Container(
                  width: 200.0,
                  child:Chip(
                    backgroundColor: getColor(pokemon.type[1]),
                    label: Center(child:Text(pokemon.type[1])),
                  )
                )
              ],
            )
          : Center(
            child: Container(
              width: 200.0,
              child:Chip(
                backgroundColor: getColor(pokemon.type[0]),
                label: Center(child:Text(pokemon.type[0]))
              )
            )
          )
            
          )
        ],

      )
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
    text = text[0].toUpperCase() + text.substring(1);
    if(pokemonItem.type.length == 1){
    if(pokemonItem.name.contains(text) || pokemonItem.idNum.contains(text) || pokemonItem.type[0].contains(text))
      searchResults.add(pokemonItem);
    }
    else{
      if(pokemonItem.name.contains(text) || pokemonItem.idNum.contains(text) || pokemonItem.type[0].contains(text) || pokemonItem.type[1].contains(text))
      searchResults.add(pokemonItem);
    }
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