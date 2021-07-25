import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedec/poke.dart';

class Pokedetail extends StatelessWidget {
  final Pokemon pokemon;
  Pokedetail({required this.pokemon});
  
  
  
  bodywidget(BuildContext context)=>Stack(
    children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width - 20,
          left: 10.0,
          top:MediaQuery.of(context).size.height*0.1 ,
           child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              
            ),
            elevation: 15.0,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height:30),
                  Text(pokemon.name,style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 30)),
                  Text("Height :${pokemon.height}",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 15)),
                  Text("weight :${pokemon.weight}",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 15)),
                  Text("Types",style: GoogleFonts.lato(fontWeight: FontWeight.w700,fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type.map((e) => FilterChip(backgroundColor: Colors.amberAccent.shade200,label: Text(e,style: GoogleFonts.lato(fontWeight: FontWeight.w600)),onSelected: (b){},)).toList(),
                  ),
                  Text("Weakness",style: GoogleFonts.lato(fontWeight: FontWeight.w700,fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses.map((g) => FilterChip(backgroundColor: Colors.redAccent.shade100,label: Text(g,style: GoogleFonts.lato(fontWeight: FontWeight.w600)),onSelected: (b){},)).toList(),
                  ),
                  
                  Text("Next Evolution",style: GoogleFonts.lato(fontWeight: FontWeight.w700,fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution.map((f) => FilterChip(backgroundColor: Colors.greenAccent.shade200,label: Text(f.name,style: GoogleFonts.lato(fontWeight: FontWeight.w600)),onSelected: (b){},)).toList(),
                  ),
            ],
            )
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(tag:pokemon.img ,
             child:Container(
                height:190.0 ,
                width: 190.0,
                child:CachedNetworkImage(
                                imageUrl: pokemon.img,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: CircularProgressIndicator(color: Colors.cyan,)),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
          ) ,

          ),
        )
    ],
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: Colors.cyan,
        elevation: 0,

      ),
      backgroundColor: Colors.cyan,
      body: bodywidget(context),
    );
  }
  
}