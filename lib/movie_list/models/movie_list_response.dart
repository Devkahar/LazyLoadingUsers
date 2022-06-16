import 'package:lazy_app/movie_list/movie_list.dart';

class MovieListResponse {
  const MovieListResponse({
    this.results = const [],
    this.pages = 0,
  });

  final List<Movie> results;
  final int pages;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      MovieListResponse(
        results: json['results'] == null
            ? []
            : List<Movie>.from(
                (json['results'] as List<dynamic>).map(
                  (e) => Movie.fromJson(e),
                ),
              ),
        pages: json['total_pages'] ?? 0,
      );
}
