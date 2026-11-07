import 'package:dio/dio.dart';

import '../models/movie_model.dart';

class MovieRepository {
  final Dio _dio = Dio();

  // 1. Загрузка главного каталога с сортировкой по рейтингу
  Future<List<MovieModel>> fetchMovies() async {
    try {
      final response = await _dio.get('https://api.tvmaze.com/shows');
      final List rawData = response.data;

      final List<MovieModel> movies = rawData
          .map((json) => MovieModel.fromJson(json))
          .toList();

      // Сортируем список: от самых высоких оценок к более низким
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies;
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  // 2. Поиск по названию (также с сортировкой лучших результатов наверх)
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        'https://api.tvmaze.com/search/shows?q=$query',
      );
      final List rawData = response.data;

      final List<MovieModel> movies = rawData
          .map((item) => MovieModel.fromJson(item['show']))
          .toList();

      // Сортируем найденные фильмы по рейтингу
      movies.sort((a, b) => b.rating.compareTo(a.rating));

      return movies;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}
