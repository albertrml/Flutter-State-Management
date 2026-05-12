# Flutter State Management — BLoC/Cubit

This module demonstrates state management in Flutter using the
`flutter_bloc` package and the Cubit pattern.

The example simulates a movie catalog application with:

- Remote data fetching
- Genre filtering
- Loading states
- Error handling
- Reactive UI updates

---

# Architecture Overview

The implementation follows a simplified layered architecture:

```text
UI Layer
│
├── Home
├── GenreFilter
├── MovieCard
│
State Layer
│
├── MovieCubit
├── Response<T>
│
Data Layer
│
├── MovieApi
│
Domain Layer
│
├── Movie
├── Exceptions
```

---

# Why Cubit?

Cubit is a lightweight version of BLoC.

Instead of handling events and streams manually,
Cubit exposes methods that directly emit new states.

This approach is ideal for:

- Small and medium applications
- Simple state transitions
- Reduced boilerplate
- Easier learning curve

---

# Core Concepts

## 1. Cubit

The Cubit is responsible for:

- Managing application state
- Executing business logic
- Communicating with services
- Emitting new UI states

```dart
class MovieCubit extends Cubit<Response<List<Movie>>> {
```

The generic type represents the state emitted by the Cubit.

In this case:

```dart
Response<List<Movie>>
```

The UI reacts whenever a new state is emitted.

---

## 2. Reactive States

The application uses a sealed generic state wrapper.

```dart
sealed class Response<T> {
  const Response();

  factory Response.success(T data) = Success<T>;
  factory Response.failure(Exception exception) = Failure<T>;
  factory Response.loading() = Loading<T>;
}
```

This creates three possible states:

| State | Description |
|---|---|
| Loading | Data is being fetched |
| Success | Data loaded successfully |
| Failure | An error occurred |

---

## 3. Loading State

Before starting the request:

```dart
emit(Response.loading());
```

The UI automatically rebuilds and displays a loading indicator.

```dart
CircularProgressIndicator()
```

---

## 4. Success State

After fetching the movies:

```dart
emit(Response.success(movies));
```

The UI rebuilds and displays the movie grid.

---

## 5. Failure State

Errors are converted into reactive states.

```dart
emit(Response.failure(error));
```

This avoids throwing exceptions directly into the UI layer.

---

# MovieCubit Implementation

```dart
class MovieCubit extends Cubit<Response<List<Movie>>> {
  final MovieApi _service;

  MovieCubit({MovieApi? service})
      : _service = service ?? MovieApi.instance(),
        super(Response.loading());

  Future<void> getMovies({String genre = defaultGenre}) async {
    emit(Response.loading());

    try {
      final List<Movie> movies =
          await _service.fetchMovies(genre: genre);

      if (movies.isEmpty) {
        throw EmptyMovieListException(genre);
      }

      emit(Response.success(movies));

    } on EmptyMovieListException catch (error) {

      emit(Response.failure(error));

    } catch (_) {

      emit(
        Response.failure(
          Exception('Failed to load movie list'),
        ),
      );
    }
  }
}
```

---

# UI Reaction with BlocBuilder

The UI subscribes to Cubit state changes using:

```dart
BlocBuilder<MovieCubit, Response<List<Movie>>>(
```

Whenever the Cubit emits a new state,
the builder rebuilds automatically.

---

# Pattern Matching with switch

Dart pattern matching makes state handling cleaner.

```dart
switch (state) {

  case Success<List<Movie>>(:final data):

  case Failure<List<Movie>>(:final exception):

  case Loading<List<Movie>>():
}
```

This avoids manual casting and improves readability.

---

# Genre Filtering

The genre filter interacts directly with the Cubit.

```dart
widget.movieCubit.getMovies(genre: value);
```

The Cubit performs:

1. State update
2. Data filtering
3. UI rebuild

without requiring `setState()` for the movie list.

---

# Reactive Flow

```text
User selects genre
        ↓
GenreFilter calls Cubit
        ↓
Cubit emits Loading
        ↓
API fetches movies
        ↓
Cubit emits Success or Failure
        ↓
BlocBuilder rebuilds UI
```

---

# Separation of Responsibilities

## UI Layer

Responsible for:

- Rendering widgets
- User interaction
- Listening to states

Should NOT contain:

- Business logic
- Networking
- Data filtering

---

## Cubit Layer

Responsible for:

- State transitions
- Business rules
- Exception handling
- Data orchestration

---

## Service Layer

Responsible for:

- HTTP requests
- JSON parsing
- Remote communication

---

# Advantages of Cubit

## Simplicity

Less boilerplate than traditional BLoC.

---

## Predictable State Flow

All state changes are centralized.

---

## Testability

Business logic becomes easier to test independently.

---

## Reactive UI

Widgets rebuild automatically when state changes.

---

## Scalability

The pattern scales well for medium and large applications.

---

# Comparison with Other Flutter State Solutions

| Solution | Complexity | Boilerplate | Best Use |
|---|---|---|---|
| setState | Low | Very Low | Local UI state |
| ValueNotifier | Low | Low | Simple reactive state |
| Provider | Medium | Low | Shared app state |
| Cubit | Medium | Medium | Business logic + reactive flows |
| Full BLoC | High | High | Large enterprise apps |

---

# Important Concepts Learned

This implementation demonstrates:

- Reactive programming
- Unidirectional data flow
- Separation of concerns
- State-driven UI
- Error handling
- Generic states
- Pattern matching
- Async state management

---

# Technologies Used

- Flutter
- flutter_bloc
- Cubit
- HTTP package
- Dart sealed classes
- Dart pattern matching

---

# Conclusion

Cubit provides a clean and scalable way to manage state in Flutter.

Compared to simpler approaches like `setState`,
Cubit centralizes business logic and creates a predictable
reactive architecture.

This implementation demonstrates how Flutter applications
can evolve from local UI state management into a more
structured reactive architecture suitable for real-world apps.
