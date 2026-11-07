import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/movie_bloc.dart';
import '../../logic/bloc/movie_event.dart';
import '../../logic/bloc/movie_state.dart';
import '../widgets/movie_card.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MOVIE EXPLORER',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Поисковая строка
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: TextField(
              onChanged: (query) {
                context.read<MovieBloc>().add(SearchMoviesEvent(query));
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies or shows...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFFC107)),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Отображение списков через BLoC
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFC107)),
                  );
                } else if (state is MovieLoaded) {
                  if (state.movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MovieBloc>().add(FetchMoviesEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
