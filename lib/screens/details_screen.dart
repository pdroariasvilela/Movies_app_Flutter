import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';
import 'package:pelicula_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si es nulo          entonces      mando 'no-movie'
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    //explicacion ModalRoute , video 112  / min 1:25

    return Scaffold(
      body: CustomScrollView(
        //hecho para trabajar son slivers
        slivers: [
          // comportamiento PRE-PROGRAMADO cuando se hace scroll en el contenido del padre
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              //Puedo poner mi lista de widget estaticos
              _PosterAndTitle(
                movie: movie,
              ),
              _OverView(movie: movie),
              _OverView(movie: movie),
              _OverView(movie: movie),
              CastingCards(movie.id, movieId: movie.id,),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //Parecido al normal , solo que aqui se controla el ancho y alto.
      backgroundColor: Colors.amber,
      expandedHeight: 200,
      floating: false,
      pinned: true, // Para que el appbar se siga viendo a pesar de que bajamos
      flexibleSpace: FlexibleSpaceBar(
        // widget especial
        centerTitle: true,
        titlePadding: EdgeInsets.all(0), // Se come el padding sobrante
        title: Container(
          color: Colors.black26,
          width: double.infinity,
          alignment: Alignment.bottomCenter, // Centrado abajo
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.BackdropPath),
          fit: BoxFit
              .cover, // expanda todo lo que pueda sin perder dimensiones de la imagen.
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({super.key, required this.movie});
  // debajo del SliverAppBar

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        // fila
        ClipRRect(
          // redondear
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImg),
            height: 150, //alto
          ),
        ),

        SizedBox(width: 5),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //size texto   //sin espacio , coloca 3 puntos  //si se pasa de dos lineas
              Text(
                movie.title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.title,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('movie.voteAverage', style: textTheme.caption)
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        movie.overview,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.justify, //Alinear texto
      ),
    );
  }
}
