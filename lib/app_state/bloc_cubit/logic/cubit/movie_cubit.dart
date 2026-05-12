import 'package:bloc/bloc.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/genre.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie_exception.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/service/movie_api.dart';

part 'response.dart';

class MovieCubit extends Cubit<Response<List<Movie>>> {
  final MovieApi _service;

  MovieCubit({MovieApi? service})
    : _service = service ?? MovieApi.instance(),
      super(Response.loading());

  Future<void> getMovies({String genre = defaultGenre}) async {
    emit(Response.loading());
    try {
      final List<Movie> movies = await _service.fetchMovies(genre: genre);
      if (movies.isEmpty) throw EmptyMovieListException(genre);
      emit(Response.success(movies));
    } on EmptyMovieListException catch (error) {
      if (genre != defaultGenre) {
        emit(Response.failure(error));
      } else {
        Exception('Não foi possível carregar a lista de filmes');
      }
    } catch (error) {
      emit(
        Response.failure(
          Exception('Não foi possível carregar a lista de filmes'),
        ),
      );
    }
  }
}
