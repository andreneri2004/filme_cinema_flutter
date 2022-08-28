import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class ActorDetails extends StatelessWidget {
  const ActorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //pega os parametros passado
    final Cast actor = ModalRoute.of(context)!.settings.arguments as Cast;
    //Utiliza o Provider
    final moviesProvider = Provider.of<MovieProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getActorDetails(actor.id),
      builder: (_, AsyncSnapshot<AtorResponse> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.indigo,
            ),
          );
        }
        final actorDetails = snapshot.data!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _CustomAppBar(
                actor: actorDetails,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                _PostAndTitle(actorDetails: actorDetails),
                _Biography(actorDetails: actorDetails),
              ])),
            ],
          ),
        );
      },
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final AtorResponse actor;

  const _CustomAppBar({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
      expandedHeight: 200,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          width: double.infinity,
          color: Colors.black12,
          child: Text(
            actor.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
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

class _PostAndTitle extends StatelessWidget {
  final AtorResponse actorDetails;
  const _PostAndTitle({Key? key, required this.actorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actorDetails.fullprofilePathImg),
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                actorDetails.name,
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ))
        ],
      ),
    );
  }
}

class _Biography extends StatelessWidget {
  final AtorResponse actorDetails;
  const _Biography({Key? key, required this.actorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: actorDetails.biography != "" ?  Text(
        actorDetails.biography,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ):  Text('Tradução para a lingua portuguesa da biografia indisponível no momento',style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}
