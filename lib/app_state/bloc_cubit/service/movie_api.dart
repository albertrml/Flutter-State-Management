import 'dart:convert';

import 'package:flutter_state_management/app_state/bloc_cubit/model/genre.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  MovieApi._();

  static final MovieApi? _instance = null;

  static MovieApi instance() => _instance ?? MovieApi._();

  Future<List<Movie>> fetchMovies({String genre = defaultGenre}) async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/alura-cursos/3033-bloc-com-cubit/main/lib/movies.json',
      ),
    );

    final json = jsonDecode(response.body);

    final list = List<Movie>.from(
      json['filmes'].map((element) => Movie.fromJson(element)),
    );

    if (genre == defaultGenre) {
      return list;
    } else {
      return list.where((element) => element.genre == genre).toList();
    }
  }
}
