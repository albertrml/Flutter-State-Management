sealed class MovieException implements Exception {
  final String message;

  const MovieException(this.message);

  @override
  String toString() => message;
}

final class EmptyMovieListException extends MovieException {
  final String genre;

  EmptyMovieListException(this.genre)
    : super("Não há filmes na categoria $genre");
}
