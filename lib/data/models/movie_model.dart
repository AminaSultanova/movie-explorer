class MovieModel {
  final int id;
  final String title;
  final String image;
  final double rating;
  final List<String> genres;
  final String summary;
  final String premiered;

  MovieModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.genres,
    required this.summary,
    required this.premiered,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Удаляем HTML-теги (<p>, <b>) из текста TVMaze
    final rawSummary = json['summary'] ?? 'No description available.';
    final cleanSummary = rawSummary.replaceAll(RegExp(r'<[^>]*>'), '');

    return MovieModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? 'Unknown Title',
      image: json['image']?['original'] ?? json['image']?['medium'] ?? '',
      rating: (json['rating']?['average'] as num?)?.toDouble() ?? 7.5,
      genres: List<String>.from(json['genres'] ?? []),
      premiered: json['premiered'] ?? 'N/A',
      summary: cleanSummary,
    );
  }
}
