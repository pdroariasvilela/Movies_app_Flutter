import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // todo ancho posible
      height: 180, //alto
      // color: Colors.red,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index)=> _CastCard()),
    );
  }
}

//Encima del CastingCards esta CastCard



class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),

      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:const  FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://dummyimage.com/200x300'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              ),
          ),

          const SizedBox( height: 5,),

          const Text(
            'Actor.name Arias Vilela Vilela Vilela Vilela', 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
