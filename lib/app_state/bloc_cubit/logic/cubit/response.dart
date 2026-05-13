/* 
 * 2. `part of` allows this file to share the same library context
 * as movie_cubit.dart, where the Cubit implementation is defined.
 */
part of 'movie_cubit.dart';

/* 
 * 1. Cubit requires a state type that represents all possible
 * states of an asynchronous operation.
 *
 * In this implementation, Response<T> models the possible async
 * states:
 *
 * - Loading
 * - Success
 * - Failure
 *
 * The generic type T represents the type of data associated
 * with the successful state.
 *
 * In this case, T is List<Movie>.
 */
sealed class Response<T> {
  const Response();

  factory Response.success(T result) = Success<T>;
  factory Response.failure(Exception exception) = Failure<T>;
  factory Response.loading() = Loading<T>;
}

final class Success<T> extends Response<T> {
  final T result;
  const Success(this.result);
}

final class Failure<T> extends Response<T> {
  final Exception exception;

  const Failure(this.exception);

  String getFailureMessage(String? msg) => msg ?? exception.toString();
}

final class Loading<T> extends Response<T> {
  const Loading();
}
