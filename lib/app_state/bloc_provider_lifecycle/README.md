# Bloc Provider Lifecycle

This example demonstrates how Cubit lifecycle management works in Flutter using `flutter_bloc`.

The goal is to understand:

- manual Cubit management
- automatic lifecycle management
- differences between `BlocProvider(create:)`
- differences between `BlocProvider.value`
- when `close()` is required
- ownership responsibility

---

# Concepts

In BLoC/Cubit architecture, a Cubit internally manages Streams and resources.

Because of that, every Cubit must eventually be disposed using:

```dart
cubit.close()
```

The important question is:

> Who owns the Cubit lifecycle?

The answer determines who is responsible for disposing it.

---

# Lifecycle Ownership

| Creation Method | Owner | Automatic dispose |
|---|---|---|
| Manual instance | Widget/Class | ❌ No |
| BlocProvider(create:) | BlocProvider | ✅ Yes |
| BlocProvider.value | External owner | ❌ No |

---

# Example Structure

This screen compares two approaches side-by-side.

Each section demonstrates a different lifecycle behavior.

---

# BlocProvider(create:)

## Purpose

`BlocProvider(create:)` creates and owns the Cubit.

Example:

```dart
BlocProvider(
  create: (_) => CounterCubit(),
  child: CounterView(),
)
```

---

## Behavior

When using `create:`:

- BlocProvider creates the Cubit
- BlocProvider stores the Cubit
- BlocProvider automatically calls `close()`

This is the most common approach in Flutter applications.

---

## Advantages

- automatic resource disposal
- safer lifecycle handling
- less boilerplate
- easier maintenance
- recommended for most screens

---

## Recommended Usage

Use `BlocProvider(create:)` when:

- the screen owns the Cubit
- the Cubit is created specifically for that page
- the Cubit should die with the widget tree

---

# BlocProvider.value

## Purpose

`BlocProvider.value` exposes an already existing Cubit.

Example:

```dart
final cubit = CounterCubit();

BlocProvider.value(
  value: cubit,
  child: CounterView(),
)
```

---

## Behavior

When using `.value`:

- BlocProvider DOES NOT create the Cubit
- BlocProvider DOES NOT dispose the Cubit
- lifecycle responsibility remains external

This means:

```dart
@override
void dispose() {
  cubit.close();
  super.dispose();
}
```

must be implemented manually.

---

## Advantages

Useful for:

- sharing Cubits across routes
- reusing existing instances
- dependency injection
- preserving state between pages

---

## Risks

If `close()` is forgotten:

- memory leaks may occur
- streams remain alive
- async callbacks may continue executing
- unexpected state emissions may happen

---

# Manual Cubit Injection

This project also demonstrates constructor injection:

```dart
GenreFilter(movieCubit: movieCubit)
```

Instead of relying on BlocProvider lookups.

This approach helps understanding:

- dependency injection
- explicit ownership
- architecture separation
- state manager sharing

---

# Important Lifecycle Rule

## If you create the Cubit manually:

```dart
final cubit = MovieCubit();
```

You MUST dispose it manually:

```dart
@override
void dispose() {
  cubit.close();
  super.dispose();
}
```

---

# Educational Purpose

This example was intentionally designed without automatic providers first.

The goal is to help understand:

- how Cubit actually works
- ownership responsibility
- provider lifecycle
- automatic vs manual disposal
- architectural implications

---

# Technologies Used

- Flutter
- flutter_bloc
- Cubit
- BlocProvider
- State Management
- Dependency Injection

---

# Key Takeaways

| Concept | Explanation |
|---|---|
| Cubit owns state | Emits states through Streams |
| Streams require disposal | `close()` is mandatory |
| create: owns lifecycle | automatic dispose |
| value: shares instance | manual dispose required |
| Constructor injection | explicit dependency passing |
| BlocBuilder | rebuilds UI on state changes |

---

# Conclusion

Understanding Cubit lifecycle is essential for building scalable Flutter applications.

This example demonstrates that state management is not only about updating UI, but also about:

- ownership
- lifecycle control
- resource management
- architecture decisions

Mastering these concepts helps avoid:

- memory leaks
- duplicated state
- invalid emissions
- unexpected behavior

and leads to cleaner, safer, and more maintainable Flutter applications.
