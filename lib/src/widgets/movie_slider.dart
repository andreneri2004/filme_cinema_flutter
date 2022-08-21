import 'package:filme_info/src/model/model.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function nextPage;
  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.nextPage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  //para funcionar bem tem que ser um statefull
  final ScrollController scrollControllerPopular = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollControllerPopular.addListener(() {
      if (scrollControllerPopular.position.pixels >=
          scrollControllerPopular.position.maxScrollExtent - 200) {
        widget.nextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
                controller: scrollControllerPopular,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, index) {
                  final movie = widget.movies[index];
                  return _MoverPoster(
                    movie: movie, heroId: '${widget.title}-${index}-${movie.id}'
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _MoverPoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoverPoster({
    Key? key,
    required this.movie, required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;


    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movie),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.cover,
                    width: 130,
                    height: 190,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
