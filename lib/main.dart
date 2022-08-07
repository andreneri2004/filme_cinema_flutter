import 'package:filme_info/src/providers/movie_provider.dart';
import 'package:filme_info/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> MovieProvider(), lazy: false,
          ),
      ],
      child: const  MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filme Info',
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.indigo, elevation: 0)),
      home: const HomeScreen(),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen()
      },
    );
  }
}
