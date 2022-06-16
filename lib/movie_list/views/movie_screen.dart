import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_app/movie_list/repository/movie_list_repository.dart';
import 'package:lazy_app/user_list/user_list.dart';

import '../controller/movie_list_controller.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final movieData = ref.watch(movieListControllerProvider);
          final status = movieData.status;
          if (status == MovieListStatus.fetchingMovieList) {
            return const Center(child: CircularProgressIndicator());
          } else if (status == MovieListStatus.fetchMovieListError) {
            return const Center(
              child: Text(
                'Error',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (ctx, idx) =>  Image.network(movieData.movies[idx].picture),

              itemCount: movieData.movies.length,
            );
          }
        },
      ),
    );
  }
}
