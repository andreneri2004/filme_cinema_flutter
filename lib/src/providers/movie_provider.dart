import 'package:flutter/material.dart';

import 'package:filme_info/src/model/model.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'fdff8198e4fb2043ddda5d4057cdcf89';
  final String _language = 'pt-BR';

  //Método padão
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  List<Movie> onTopRatedMovies = [];

  //método avançado.... carregar somente quando fizer solicitação/ e salva na mémoria.

  Map<int, List<Cast>> moviesCast = {};

  //para o funcionamento do scrollController
  int _popularPage = 0;
  int _topRatedPage = 0;


  //Criando infinito scroll da pagina

  MovieProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
  }

  Future<String> getJsonData(String subUrl, [int page = 1]) async {
    var url = Uri.https(_baseUrl, subUrl,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final response = await getJsonData('3/movie/now_playing');
    final NowPlayResponse nowPlayResponse = NowPlayResponse.fromJson(response);
    onDisplayMovies = nowPlayResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    //toda vez que chegar no fim o movieSlider chama essa função
    _popularPage++;
    final response = await getJsonData('3/movie/popular', _popularPage);
    final PopularMovieResponse popularMovieResponse =
        PopularMovieResponse.fromJson(response);
    onPopularMovies = [...onPopularMovies, ...popularMovieResponse.results];

    notifyListeners();
  }

  getTopRatedMovies() async {

    //toda vez que chegar no fim o movieSlider chama essa função
    _topRatedPage++;
    final response = await getJsonData('3/movie/top_rated', _topRatedPage);
    final TopRatedResponse topRatedResponse =
        TopRatedResponse.fromJson(response);
    onTopRatedMovies = [...onTopRatedMovies, ...topRatedResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    //Revisa mapa para vê se já tem
    print('Recuperando informação ao servidor - Atores');
    final response = await getJsonData('3/movie/$movieId/credits', _topRatedPage);
    final creditsMovie = CreditsMoveResponse.fromJson(response);

    moviesCast[movieId] = creditsMovie.cast;

    return creditsMovie.cast;


  }
}
