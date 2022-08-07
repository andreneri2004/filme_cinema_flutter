import 'package:flutter/material.dart';
import 'package:filme_info/src/widgets/widgets.dart';
import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB - Filme e Cinema, André Neri'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CardSwiper(movies: movieProvider.onDisplayMovies),
          MovieSlider(
              movies: movieProvider.onPopularMovies,
              title: 'Populares',
              nextPage: () => movieProvider.getPopularMovies()),
          MovieSlider(
              movies: movieProvider.onTopRatedMovies,
              title: 'Mais Votados',
              nextPage: () => movieProvider.getTopRatedMovies()),
        ]),
      ),
    );
  }
}
