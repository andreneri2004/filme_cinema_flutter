import 'package:card_swiper/card_swiper.dart';
import 'package:filme_info/src/model/model.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(movies == null){
      return Container(
         width: double.infinity,
         height: size.height * 0.5,
         child: const  Center(
          child: CircularProgressIndicator(color: Colors.indigo),
         ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, index) {
          final movie = movies[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movie),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
