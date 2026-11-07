import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repo/movie_repository.dart';
import 'logic/bloc/movie_bloc.dart';
import 'logic/bloc/movie_event.dart';
import 'presentation/screens/catalog_screen.dart';

void main() {
  runApp(const MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(),
      child: BlocProvider(
        create: (context) => MovieBloc(
          movieRepository: context.read<MovieRepository>(),
        )..add(FetchMoviesEvent()),
        child: MaterialApp(
          title: 'Movie Explorer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFC107),
              surface: Color(0xFF1E1E1E),
            ),
          ),
          home: const CatalogScreen(),
        ),
      ),
    );
  }
}