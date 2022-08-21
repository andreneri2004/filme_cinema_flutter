import 'package:filme_info/src/model/model.dart';
import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  Widget _isEmptyContainer() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
        color: Colors.black38,
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Localizar Filme';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Resultados');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _isEmptyContainer();

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: movieProvider.suggestionStream,
      //quando tiver snapshot vai ter uma lista
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _isEmptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) => _MovieItem(movie: movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'swiper-${movie.id}';
    return ListTile(
      leading: Hero(tag: movie.heroId!,
      child: FadeInImage(placeholder:  const  AssetImage('assets/no-image.jpg'), image: NetworkImage( movie.fullPosterImg), width: 50, fit: BoxFit.fill)),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}