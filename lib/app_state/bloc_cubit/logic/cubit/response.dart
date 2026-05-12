part of 'movie_cubit.dart';

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
