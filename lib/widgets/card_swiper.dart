import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; // sabe todo del arbol de widget construido

    if (this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(child:CircularProgressIndicator()),
      );
    }

    return Container(
      width: double.infinity, // toma todo el ancho posible
      height: size.height * 0.5, // LA MITAD DEL SCAFOLD - SE USA CON MEDIAQUERY
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length, // numero de Items

        layout: SwiperLayout.STACK, //tipo de diseño (Layout) / uno tras de otro
        itemWidth: size.width * 0.5, // ANCHO
        itemHeight: size.height * 0.4, // ALTO
        itemBuilder: (_, int index) {
          // UNA FUNCION PARA CONSTRUIR NUEVO WIDGETS

          final movie =
              movies[index]; //tema provider , se pone despues de hacer todo+
          print(movie.fullPosterImg);

          return GestureDetector(
            //permite ponerle ontap , para irse a otra pantalla.
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              // redondear puntas de caja de contenido
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                // ANIMACION DE ENTRADA

                placeholder: const AssetImage(
                    'assets/no-image.jpg'), //IMAGEN QUE QUIERO QUE MUESTRE ANTES
                image: NetworkImage(movie.fullPosterImg),

                fit: BoxFit
                    .cover, // adaptar la imagen que tiene el contenedor padre
              ),
            ),
          );
        },
      ),
    );
  }
}
