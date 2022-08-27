import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class ActorDetails extends StatelessWidget {
  const ActorDetails({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    final Cast actor  = ModalRoute.of(context)!.settings.arguments as Cast;
    final moviesProvider = Provider.of<MovieProvider>(context);

    final resul = moviesProvider.getActorDetails(actor.id);
  //print();
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(actor: actor,),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Cast actor;
  
  const _CustomAppBar({Key? key, required this.actor, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const  Color.fromRGBO(3, 37, 65, 1),
      expandedHeight: 200,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          width: double.infinity,
          color: Colors.black12,
          child:  Text(actor.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(actor.fullprofilePathImg),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}