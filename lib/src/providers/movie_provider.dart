import 'package:flutter/material.dart';

import 'dart:async';
import 'package:filme_info/src/helpers/debouncer.dart';
import 'package:filme_info/src/model/actor_response.dart';
import 'package:filme_info/src/model/model.dart';
import 'package:filme_info/src/model/search_movie_response.dart';
import 'package:filme_info/src/screens/screens.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '';
  final String _language = 'pt-BR';

  //Método padão
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  List<Movie> onTopRatedMovies = [];
  //método avançado.... carregar somente quando fizer solicitação/ e salva na mémoria.

  Map<int, List<Cast>> moviesCast = {};

  Map<int, dynamic> actorList = {};

  //para o funcionamento do scrollController
  int _popularPage = 0;
  int _topRatedPage = 0;

  //Controle da requisição quando é digitado no seach

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  //Criando infinito scroll da pagina

  MovieProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
  }

  Future<String> getJsonData(String subUrl, {int page = 1, String  language = 'pt-BR'}) async {
    final url = Uri.https(_baseUrl, subUrl,
        {'api_key': _apiKey, 'language': language, 'page': '$page'});

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
    final response = await getJsonData('3/movie/popular', page: _popularPage);
    final PopularMovieResponse popularMovieResponse =
        PopularMovieResponse.fromJson(response);
    onPopularMovies = [...onPopularMovies, ...popularMovieResponse.results];

    notifyListeners();
  }

  getTopRatedMovies() async {
    //toda vez que chegar no fim o movieSlider chama essa função
    _topRatedPage++;
    final response = await getJsonData('3/movie/top_rated', page: _topRatedPage);
    final TopRatedResponse topRatedResponse =
        TopRatedResponse.fromJson(response);
    onTopRatedMovies = [...onTopRatedMovies, ...topRatedResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final response =
        await getJsonData('3/movie/$movieId/credits', page: _topRatedPage);
    final creditsMovie = CreditsMoveResponse.fromJson(response);

    moviesCast[movieId] = creditsMovie.cast;

    return creditsMovie.cast;
  }

  Future <AtorResponse> getActorDetails(int actorId, {String language = "pt-BR"}) async {
    if(actorList.containsKey(actorId)) return actorList[actorId]!;

    final response = await getJsonData('3/person/$actorId', language: language);

    final actorDetails = AtorResponse.fromJson(response);

    actorList[actorId] = actorDetails;

    return actorDetails;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language':  _language, 'query': query});

    final response = await http.get(url);

    final searchResult = SearchMoveResponse.fromJson(response.body);

    return searchResult.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovies(value);
      _suggestionStreamController.add(result);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
