import 'package:bloc/bloc.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/genre.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie_exception.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/service/movie_api.dart';

/*
 * 3. The `part` directive connects this file to response.dart, where the async
 * state classes are defined.
 */
part 'response.dart';

/*
 * 4. A Cubit class must extend Cubit<T>, where T represents
 * the state managed by the Cubit.
 *
 * To use Cubit, install the dependencies:
 *
 * $ flutter pub add bloc flutter_bloc
 *
 * In this example, Response<List<Movie>> defines the possible
 * states emitted during the movie loading process.
 */
class MovieCubit extends Cubit<Response<List<Movie>>> {
  /*
   * This service layer is responsible for performing HTTP requests
   * and retrieving movie data from the API.
   */
  final MovieApi _service;

  /*
   * 5. Every Cubit must define an initial state through
   * the super constructor.
   *
   * Here, the initial state is Loading.
   */
  MovieCubit({MovieApi? service})
    : _service = service ?? MovieApi.instance(),
      super(Response.loading());

  /*
   * 6. Cubit methods usually return void because state changes
   * are propagated through emit().
   *
   * However, this method returns Future<void> because it performs
   * asynchronous work.
   *
   * The common async state flow is:
   *
   * emit(LoadingState());
   *
   * try {
   *   final data = await repository.fetch();
   *   emit(SuccessState(data));
   * } catch (error) {
   *   emit(ErrorState(error));
   * }
   */
  Future<void> getMovies({String genre = defaultGenre}) async {
    emit(Response.loading());

    try {
      final List<Movie> movies = await _service.fetchMovies(genre: genre);

      if (movies.isEmpty) {
        throw EmptyMovieListException(genre);
      }
      /*
       * 7. This check prevents state emission after the Cubit
       * has already been disposed.
       *
       * Example:
       * - the user opens the screen
       * - an API request starts
       * - the user leaves the screen before completion
       *
       * Without this check, emit() could be called on a closed
       * Cubit instance.
       */
      if (!isClosed) {
        emit(Response.success(movies));
      }
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
