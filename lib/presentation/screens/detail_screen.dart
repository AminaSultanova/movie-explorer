import 'package:flutter/material.dart';

import '../../data/models/movie_model.dart';

class DetailScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Шапка с банером и кнопкой "Назад"
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: const Color(0xFF121212),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  movie.image.isNotEmpty
                      ? Image.network(movie.image, fit: BoxFit.cover)
                      : Container(color: Colors.grey[900]),
                  // Тёмный градиент для читаемости текста
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          const Color(0xFF121212),
                        ],
                        stops: const [0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Основная информация
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Строка с рейтингом и датой премьеры
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Premiered: ${movie.premiered}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Жанры в виде тегов-кнопок
                  if (movie.genres.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genres.map((genre) {
                        return Chip(
                          label: Text(genre),
                          backgroundColor: const Color(0xFF1E1E1E),
                          side: BorderSide(color: Colors.grey[800]!),
                          labelStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  const Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Очищенный сюжет фильма
                  Text(
                    movie.summary,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
