import 'package:flutter/material.dart';
import 'package:pelicula_app/providers/movies_provider.dart';
import 'package:pelicula_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Peliculas en Cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
          // PERMITE HACER SCROLL

          child: Column(children: [
        //TARJETAS PRINCIPALES
        CardSwiper(movies : moviesProvider.onDisplayMovies), //clase de provider revisarla

        // SLIDER DE PELICULAS
        MovieSlider(
          movies : moviesProvider.popularMovies,
          title: 'Populares ! ' ,
          onNextPage: () => moviesProvider.getPopularMovies(),
          ),
      ])),
    );
  }
}
