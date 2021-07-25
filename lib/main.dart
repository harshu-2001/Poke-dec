import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:pokedec/poke.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedec/pokemon.dart';

void main() =>runApp(MaterialApp(
  home: Home(),
  title: "Poke App",
  debugShowCheckedModeBanner: false,
));
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json';
  
  var decoder;
  late Poke poke;

  var keyrefresh=GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    fetchdata();

  }
  
  Future fetchdata() async {
    keyrefresh.currentState?.show();
    var res = await http.get(Uri.parse(url));
    decoder = jsonDecode(res.body);   
    setState(() {
      poke = Poke.fromJson(decoder);
    });


    //print(res.body);
  }

  @override
  Widget build(BuildContext context) {
      //Poke poke = Poke.fromJson(decoder);
        return Scrollbar(
                  child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("Poke App",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 20))),
              elevation: 1,
              backgroundColor: Colors.cyan,
            ),
            body: decoder==null?RefreshIndicator(
              key: keyrefresh,
              onRefresh: () async { fetchdata(); },
               child:Center()
               )
            :RefreshIndicator(
              key: keyrefresh,
                onRefresh: () async { fetchdata(); },
                child: GridView.count(
                crossAxisCount: 2,
                children: poke.pokemon.map((pokem) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Pokedetail(pokemon: pokem)));
                    },
                    child: Hero(
                      tag: pokem.img,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height:100.0,
                              width: 100.0,
                              child: CachedNetworkImage(
                                  imageUrl: pokem.img,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: CircularProgressIndicator(color: Colors.cyan,)),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),

                           ),
                           Text(pokem.name
                          ,style: GoogleFonts.lato(fontWeight: FontWeight.w700,fontSize: 18)
                           ),
                          ],
                        ),
                      ),
                    )
                    ),
                )).toList(),
      ),
            ),
      
    ),
        );
  }

}
