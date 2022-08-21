import 'package:flutter/material.dart';

import '../model/model.dart';

class ActorDetails extends StatelessWidget {
  const ActorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor:  Color.fromRGBO(3, 37, 65, 1),
      expandedHeight: 200,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          width: double.infinity,
          color: Colors.black12,
          child: Text('actor.name', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage('https://www.themoviedb.org/t/p/w300_and_h450_bestv2/vkoSSVrGxFYvtr2uUdz99ENXF1v.jpg'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}