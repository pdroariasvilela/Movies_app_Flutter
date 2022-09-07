import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
//ejecutar el codigo cuando por primera vez es construido.
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
// cuando el widget es destruido
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // TOMATODO EL ANCHO POSIBLE
      height: 270, //ALTO
      // color: Colors.red,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),

          const SizedBox(
            height: 5,
          ),
          //SE COLOCA EN UN EXPANDED YA QUE GENERARA UN ERROR , PORQUE TIENE UN ANCHO DEFINIDO POR LOS HIJOS
          // Y UN LISTVIEW.BUILDER DEFINE SU ANCHO BASADO EN EL PADRE
          // CON DOS LINEAS DE CODIGO SE PUEDE ARREGLAR (ESTA COMENTADO ARRIBA DE itemcount:20)
          Expanded(
            //DA EL TAMAÑANO QUE QUEDA DISPONIBLE

            child: ListView.builder(
                controller: scrollController,
                // DEFINE SU ANCHO BASADO EN EL PADRE
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                scrollDirection:
                    Axis.horizontal, //COLOCA EL SCROLL EN HORIZONTAL
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) => _MoviePoster(
                      widget.movies[index], '${widget.title}-${index}-${widget.movies[index].id}'
                    )),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.herId = heroId;
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          movie.title,
          maxLines: 2, // se crea una nueva linea para la palabra que es larga
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}

//kk 
