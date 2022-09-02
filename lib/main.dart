import 'package:flutter/material.dart';
import 'package:pelicula_app/providers/movies_provider.dart';
import 'package:pelicula_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  MultiProvider( //Listados de provider o 'servicios'
      providers: [
        //tengo que inicializar mi instancia de MoviesProviders
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,),
      ],
      child: MyApp(),
      );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.green,)),
    );
  }
}
