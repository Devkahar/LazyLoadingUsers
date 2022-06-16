import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_app/movie_list/movie_list.dart';

final movieListRepositoryProvider = Provider(
      (ref) => MovieListRepository(),
);
class MovieListRepository {
  final _client = http.Client();

  Future<MovieListResponse> fetchMovieList({
    required int page,
    required String category,
  }) async {
    final url = 'https://api.themoviedb.org/3/movie/$category?api_key=f74b99c43701d44b26c5b18cb07bf4a0&language=en-US&page=$page';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = MovieListResponse.fromJson(json);
      return result;
    } else {
      throw 'Failed to fetch Movies.';
    }
  }
}
