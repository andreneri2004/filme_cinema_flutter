import 'package:filme_info/src/model/model.dart';
import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({Key? key, required this.movieid}) : super(key: key);

  final int movieid;

  @override
  Widget build(BuildContext context) {
    //Faz parte da consulta por ai, onde vai salvar na memoria

    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieid),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        //caso não tenha nada no MAP DE moviesCast

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.indigo,
            ),
          );
        }
        
        final cast = snapshot.data;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => const _CastCard()),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Flexible(
            child: GestureDetector(
              //onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movies-slider'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://dummyimage.com/300'),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 140,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Nome do ator aqui',
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
