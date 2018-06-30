import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => 
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));


class MyApp extends StatefulWidget{
  @override
  PokeDexState createState() => PokeDexState();
}

//Pokemon class that contains data on the Pokemon that is mapped from the Json file.
class Pokemon{
  final int id;
  final String name;
  final String idNum;
  final String url;
  final String height;
  final String weight;
  final String candy;
  final String candyImg;
  final String egg;
  final int candyCount;
  final List nextEvo;
  final List prevEvo;
  final List type;
  final List weaknesses;
  final String spawnChance;
  final String spawnTime;


  Pokemon.fromJsonMap(Map map)
  : id = map['id'],
    name = map['name'],
    idNum = map['num'],
    url = map['img'],
    type = map['type'],
    height = map['height'],
    weight = map['weight'],
    candy = map['candy'],
    candyImg = map['candy_img'],
    weaknesses = map['weaknesses'],
    nextEvo = map['next_evolution'],
    prevEvo = map['prev_evolution'],
    egg = map['egg'],
    candyCount = map['candy_count'],

    spawnChance = map['spawn_chance'].toString(),
    spawnTime = map['spawn_time'];

}

//Pokemon Page that contains the information the selected pokemon
class PokemonInfoPage extends StatelessWidget{
  
  /*
  Function that returns a Color Widget based on the pokemon type.

  Function takes in a String type that represents the pokemon's typing and chooses which Color to return.
  */
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

  /*
  Function that returns a Image widget based on the Pokemon's type

  Function takes in a String type that represents the pokemon's typing and chooses which Image to return.
  */

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
  PokemonInfoPage(this.pokemon, this.pokeList);
  
  final Pokemon pokemon;
  final List<Pokemon> pokeList;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(pokemon.type[0]),
        title:Text(pokemon.name, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        ),
      body: ListView(
        children: <Widget>[

          //Creates the Banner and Image of the pokemon of the listview 
          Stack(children: <Widget>[

            Container(
              child: Center(
                child:getImage(pokemon.type[0]))
            ),
            Container(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Image.network(pokemon.url),  
              )
            ),
    
          ],),
          Container(
            padding: const EdgeInsets.only(top:10.0),
            child:Center(
              child:Text('Type',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            )
          ),

          // Creates the Type section of the listview
          Container(
            child: pokemon.type.length > 1 
            ? 
              Row(
              children: <Widget>[
                Container(
                  width: 185.0,
                  child:Chip(
                    backgroundColor: getColor(pokemon.type[0]),
                    label: Center(child:Text(pokemon.type[0])),
                  )
                ),
                Container(
                  width: 185.0,
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
            
          ),

          //Creates the Weaknesses section of the listview
          Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child:Text('Weaknesses',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            )
          ),

          Container(
            child: pokemon.weaknesses.length > 1
            ?Column(
              children: <Widget>[

                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 185.0,
                        child:Chip(
                          backgroundColor: getColor(pokemon.weaknesses[0]),
                          label: Center(child:Text(pokemon.weaknesses[0]))
                        )
                      ),
                      Container(
                        width: 185.0,
                        child:Chip(
                          backgroundColor: getColor(pokemon.weaknesses[1]),
                          label: Center(child:Text(pokemon.weaknesses[1]))
                        )
                      ),
                    ],
                  )
                ),

                Container(
                  child: pokemon.weaknesses.length == 4
                  ?Row(
                    children: <Widget>[
                      Container(
                        width: 185.0,
                        child:Chip(
                          backgroundColor: getColor(pokemon.weaknesses[2]),
                          label: Center(child:Text(pokemon.weaknesses[2]))
                        )
                      ),
                      Container(
                        width: 185.0,
                        child:Chip(
                          backgroundColor: getColor(pokemon.weaknesses[3]),
                          label: Center(child:Text(pokemon.weaknesses[3]))
                        )
                      ),
                    ],
                  )
                : pokemon.weaknesses.length == 3
                ?Row(
                    children: <Widget>[
                      Container(
                        width: 185.0,
                        child:Chip(
                          backgroundColor: getColor(pokemon.weaknesses[2]),
                          label: Center(child:Text(pokemon.weaknesses[2]))
                        )
                      ),
                     
                    ],
                  )
                :null
                ),
                
              ],
            )
            :Center(
              child: Container(
                width: 200.0,
                child:Chip(
                  backgroundColor: getColor(pokemon.weaknesses[0]),
                  label: Center(child:Text(pokemon.weaknesses[0]))
              )
            )
            )
          ),

          // Creates height and weight sections of the listview
         Container(
            padding: const EdgeInsets.only(top:20.0),
            child:Row(
              children: <Widget>[                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Height', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text(pokemon.height, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Weight', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text(pokemon.weight, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  )
                ),
              ],
            )
         ),

        // Creates the type of Candy section of the listview
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Candy', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),

                      Container( 
                        width: 40.0,
                        height: 40.0,
                        child: Center(
                          child: Image.network(pokemon.candyImg)
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text(pokemon.candy, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  ),
              ),
        ),

        // Creates the Candy needed for evolution section of the listview
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: pokemon.candyCount != null 
                ? Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Candy for Evolution', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text(pokemon.candyCount.toString(), style: TextStyle(fontSize: 18.0,),),
                        ),
                      ),

                    ],
                  )
                : null
              ),
        ),


        /* Creates the Evolution Chart portion of the listview*/
        Container(
          padding: const EdgeInsets.only(top:20.0),
          child: pokemon.prevEvo != null || pokemon.nextEvo != null
          ?Center(
            child: Text('Evolution Chart', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
          )
          :null
        ),

        
        Container(
          padding: const EdgeInsets.all(10.0),
          child: pokemon.prevEvo != null || pokemon.nextEvo != null
          ?Row(
            children: pokemon.prevEvo == null && pokemon.nextEvo != null
            ?pokemon.nextEvo.length == 1
              ?<Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                      Center(
                        child: Text('#'+pokemon.idNum)
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokemon.url))
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.nextEvo[0]['name'])
                      ),
                      Center(
                        child: Text('#'+pokemon.nextEvo[0]['num'])
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id].url))
                      )
                    ],
                  ),
                ),
              ]
              :pokemon.nextEvo.length == 2
                ?<Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold),)
                        ),
                        Center(
                          child: Text('#'+pokemon.idNum)
                        ),
                        Center(
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            child:Image.network(pokemon.url))
                        )
                      ],
                      ),
                    ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(pokemon.nextEvo[0]['name'])
                          ),
                          Center(
                            child: Text('#'+pokemon.nextEvo[0]['num'])
                          ),
                          Center(
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              child:Image.network(pokeList[pokemon.id].url))
                      )
                        ],
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(pokemon.nextEvo[1]['name'])
                          ),
                          Center(
                            child: Text('#'+pokemon.nextEvo[1]['num'])
                          ),
                          Center(
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              child:Image.network(pokeList[pokemon.id+1].url))
                      )
                        ],
                      ),
                    ),
                  ]
                :null

            :pokemon.prevEvo != null && pokemon.nextEvo == null       
            ?pokemon.prevEvo.length == 1
              ?<Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.prevEvo[0]['name'])
                      ),
                      Center(
                        child: Text('#'+pokemon.prevEvo[0]['num'])
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id-2].url))
                      )
                      
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                      Center(
                        child: Text('#'+pokemon.idNum)
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokemon.url))
                      )

                    ],
                  ),
                ),
              ]
              : pokemon.prevEvo.length == 2
              ?<Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.prevEvo[0]['name'])
                      ),
                      Center(
                        child: Text('#'+pokemon.prevEvo[0]['num'])
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id-3].url))
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.prevEvo[1]['name'])
                      ),
                      Center(
                        child: Text('#'+pokemon.prevEvo[1]['num'])
                     ),
                     Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id-2].url))
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                      Center(
                        child: Text('#'+pokemon.idNum)
                      ),
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokemon.url))
                      )
                    ],
                  ),
                ),
              ]
              :null

            :pokemon.prevEvo != null && pokemon.nextEvo != null
            ?<Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(pokemon.prevEvo[0]['name'])
                    ),
                    Center(
                      child: Text('#'+pokemon.prevEvo[0]['num'])
                    ),
                    Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id-2].url))
                      )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold),)
                    ),
                    Center(
                      child: Text('#'+pokemon.idNum)
                    ),
                    Center(
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        child:Image.network(pokemon.url))
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(pokemon.nextEvo[0]['name'])
                    ),
                    Center(
                      child: Text('#'+pokemon.nextEvo[0]['num'])
                    ),
                    Center(
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          child:Image.network(pokeList[pokemon.id].url))
                      )
                  ],
                ),
              ),
            ]
            :null
          )
          : null
        ),

        //Creates the Egg section of the listivew
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Egg', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: pokemon.egg == '2 km'
                          ?Image.network('https://vignette.wikia.nocookie.net/pokemongo/images/f/f2/Egg_2k.png/revision/latest?cb=20161024212924')
                          :pokemon.egg == '5 km'
                          ?Image.network('https://vignette.wikia.nocookie.net/pokemongo/images/3/33/Egg_5k.png/revision/latest?cb=20161024212930&format=original')
                          :pokemon.egg == '7 km'
                          ?Image.network('https://vignette.wikia.nocookie.net/pokemongo/images/f/f5/Egg_7k.png/revision/latest?cb=20180620120317')
                          :pokemon.egg == '10 km'
                          ?Image.network('https://vignette.wikia.nocookie.net/pokemongo/images/f/f6/Egg_10k.png/revision/latest?cb=20161024212937')
                          :null
                        )
                      ),
                      Container(
                        child: Center(
                          child: Text(pokemon.egg, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  ),
              ),
        ),

        //Creates the Spawn chance and Spawn time of the listview
        Container(
            padding: const EdgeInsets.only(top:20.0),
            child:Row(
              children: <Widget>[                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Spawn Chance', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text('% '+pokemon.spawnChance, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container( 
                        child: Center(
                          child: Text('Spawn Time', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      
                      Container(
                        child: Center(
                          child: Text(pokemon.spawnTime, style: TextStyle(fontSize: 18.0,),),
                        ),
                      )
                    ],
                  )
                ),
              ],
            )
         ),
        ],

      )
    );
    
  }


}

//Main Pokedex Page
class PokeDexState extends State<MyApp>{

StreamController<Pokemon> streamController;
TextEditingController controller = new TextEditingController();
List<Pokemon> pokemonList = [];
List<Pokemon> searchResults = [];

/*
Async function that creates a List<Pokemon> called searchResults that contain Pokemon that are related to the search.

Function is called everytime the text is changed within the search textfield.

Pokemon are searched by their name, ID number and type

Function takes in a String text, which is the current string in the textfield.
*/  
onSearchTextChanged(String text) async{
  searchResults.clear();
  if(text.isEmpty){
    setState(() {
          return;
    });
  }
  
  pokemonList.forEach((pokemonItem){
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

 //Streams the data from the Json file and maps the information to the Pokemon class
 load(StreamController sc) async{
   String url = "https://raw.githubusercontent.com/realim1/pokemonGo-json/master/PokemonGo.json?token=AiSE9jxlXonKTqjXXzejZTpprxeAvc3Wks5bP8nMwA%3D%3D";
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
  //Function used to close the stream when data is finished loading
  @override
  void dispose(){
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  
  //Initial function that is called at the start of the application to setup the streaming & load pokemon data from json file.
  @override
  void initState(){
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) =>
      setState(() => pokemonList.add(p)
      )); 

    load(streamController);
  }

  
  //Builds the initial page that contains a Listview of the Pokemon and functional search bar. 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        backgroundColor: Colors.red,
        
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

  /* 
  Function that returns a Widget Containing Pokemon's Name, ID Number and Image(retrieved through url).
  This function is dedicated for creating the Widgets for the whole PokemonList Listview.

  Function takes in an integer index used to retrieve pokemon information from the list.
  */
  Widget _createWholeList(int index){
    if(index >= pokemonList.length){
      return null;
    }

    return GestureDetector(
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new PokemonInfoPage(
                pokemonList[index],
                pokemonList
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
                            child: Text(pokemonList[index].name, style: TextStyle(fontSize: 20.0),)
                            ) 
                          ),
                        
                        Container(
                          child: Center(
                            child: Text('#'+pokemonList[index].idNum, style: TextStyle(fontSize: 18.0),)
                            ) 
                          ),

                        Container(
                          child: Center(
                            child: Image.network(pokemonList[index].url, )
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
  /* 
  Function that returns a Widget Containing Pokemon's Name, ID Number and Image(retrieved through url).
  This function is dedicated for creating the Widgets for the searchResult Listview.

  Function takes in an integer index used to retrieve pokemon information from the list.
  */
  Widget _createSearchResultList(int index){
    if(index >= searchResults.length){
      return null;
    }

    return GestureDetector(
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new PokemonInfoPage(
                searchResults[index],
                pokemonList
                
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