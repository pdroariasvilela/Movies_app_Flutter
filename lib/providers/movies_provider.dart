import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pelicula_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '0bdd04b6b76c9b247d033afb3d90e4e6';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  //se crea un listado de movie
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    // constructor
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies(); //no es necesario colocar el this
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

 

  //Metodo donde llamamos parte del HTTP

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    // Await the http get response, then decode the json-formatted response.

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    // print(nowPlayingResponse.results[1].title);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = NowPlayingResponse.fromJson(jsonData);

    popularMovies = [
      ...popularMovies,
      ...popularResponse.results
    ]; //se desestructura
    print(popularMovies);
    notifyListeners();
  }
}
