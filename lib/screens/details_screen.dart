import 'package:flutter/material.dart';
import 'package:pelicula_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //si es nulo          entonces      mando 'no-movie'
    final String movie =ModalRoute.of(context)?.settings.arguments.toString() ?? 'no movie';
    //explicacion ModalRoute , video 112  / min 1:25

    return Scaffold(
      body: CustomScrollView(
        //hecho para trabajar son slivers
        slivers: [
          // comportamiento PRE-PROGRAMADO cuando se hace scroll en el contenido del padre
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              //Puedo poner mi lista de widget estaticos
              _PosterAndTitle(),
              _OverView(),
              _OverView(),
              _OverView(),
              CastingCards(),

  
              
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
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
          child: const Text(
            'Movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://dummyimage.com/500x300'),
          fit: BoxFit
              .cover, // expanda todo lo que pueda sin perder dimensiones de la imagen.
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {


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
          child: const FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage('https://dummyimage.com/200x300'),
            height: 150, //alto
          ),
        ),

        SizedBox(width: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //size texto   //sin espacio , coloca 3 puntos  //si se pasa de dos lineas
            Text(
              'movie.title',
              style: textTheme.headline5,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              'movie.title',
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
                Text('movie.voteAverage',
                    style: textTheme.caption)
              ],
            )
          ],
        )
      ]),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20),
      child:  Text('Commodo laboris nostrud do ut excepteur exercitation. Non irure ut dolore aliqua velit qui deserunt sit in culpa. Commodo dolore aliqua elit aliquip proident ex excepteur minim reprehenderit qui nisi. Fugiat labore ut do cillum. Mollit nulla in est enim cupidatat magna velit dolore cillum non qui. Adipisicing  do sit sit sint qui.',
      style: Theme.of(context).textTheme.subtitle1, 
      textAlign: TextAlign.justify, //Alinear texto

      ),
      
    );
  }
}