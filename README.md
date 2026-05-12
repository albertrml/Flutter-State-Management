# Flutter State Management Studies

## Overview

This project was created to study, compare, and document different state management techniques in Flutter.

The repository contains multiple examples ranging from simple local UI state to reactive architectures using Provider and Cubit.

The main objective is to understand:

- How Flutter rebuilds widgets
- How state flows through the widget tree
- Differences between local and shared state
- Reactive programming concepts
- Separation of concerns
- Scalability of state management solutions
- Architectural patterns commonly used in real-world Flutter applications

---

# Technologies

This project uses:

- Flutter
- Dart
- Provider
- flutter_bloc
- Cubit
- go_router
- HTTP

---

# Project Structure

```text
lib/
├── main.dart
├── route/
│   ├── destine.dart
│   └── go_router.dart
│
├── view/
│   ├── home_page_screen.dart
│   └── state_management_widget.dart
│
├── ephemeral_state/
│   ├── counter/
│   └── value_notifier/
│
├── app_state/
│   ├── lifting_state_up/
│   ├── multiprovider_multiconsumer/
│   └── bloc_cubit/
│
└── shared/
```

Each folder demonstrates a specific state management strategy.

---

# Navigation

The project uses declarative navigation with:

```dart
MaterialApp.router()
```

and:

```dart
go_router
```

Example:

```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePageScreen(),
    ),
  ],
);
```

Navigation can be performed using:

```dart
context.push('/route')
```

or:

```dart
context.go('/route')
```

This approach is currently the officially recommended navigation solution for Flutter applications.

---

# State Management Approaches

# 1. Ephemeral State

## Technologies

- StatefulWidget
- setState()

## Characteristics

State exists only inside the widget.

The widget itself is responsible for:

- storing state
- mutating state
- rebuilding the UI

## Best Use Cases

- Temporary UI state
- Small interactions
- Simple animations
- Widget-local behavior

## Example

- Counter screen

## Example Flow

```text
User interaction
       ↓
setState()
       ↓
Widget rebuild
       ↓
Updated UI
```

---

# 2. ValueNotifier

## Technologies

- ValueNotifier<T>
- ValueListenableBuilder

## Characteristics

A lightweight reactive state solution.

Only widgets listening to the ValueNotifier rebuild.

This approach is ideal when:

- only one value needs observation
- state belongs to a single screen
- global state management is unnecessary

## Example

- Day/Night sky mode

## Concepts Demonstrated

- Reactive rebuilds
- Animated UI updates
- Lightweight observable state

---

# 3. Lifting State Up

## Technologies

- Provider
- ChangeNotifier
- Consumer
- context.watch()
- context.read()
- context.select()

## Characteristics

The state is moved to a common parent widget and shared downward through the widget tree.

This allows multiple widgets to react to the same source of truth.

## Concepts Demonstrated

- Shared app state
- Dependency injection
- Reactive rebuilds
- Scoped rebuild optimization

## Example

- Time spent chart

## Example Flow

```text
Widget updates state
        ↓
notifyListeners()
        ↓
Provider notifies listeners
        ↓
Dependent widgets rebuild
```

---

# 4. MultiProvider and MultiConsumer

## Technologies

- MultiProvider
- MultiConsumer
- Multiple ChangeNotifiers

## Characteristics

Allows multiple independent states to coexist in the same widget tree.

Each provider is responsible for a single concern.

This improves:

- modularization
- scalability
- readability
- separation of responsibilities

## Example

- RGB color generator

## Concepts Demonstrated

- Independent reactive states
- Composition of multiple providers
- Fine-grained rebuild control

---

# 5. BLoC/Cubit

## Technologies

- flutter_bloc
- Cubit
- BlocBuilder
- Sealed states
- Pattern matching

## Characteristics

Cubit centralizes business logic and state transitions.

Unlike setState or ChangeNotifier, the UI does not mutate state directly.

Instead:

```text
UI interaction
      ↓
Cubit method
      ↓
Business logic
      ↓
New state emission
      ↓
Reactive UI rebuild
```

## Concepts Demonstrated

- Reactive architecture
- Unidirectional data flow
- Async state management
- Error handling
- API consumption
- Generic state wrappers
- State-driven UI

## Example

- Movie catalog with genre filter

## States Used

```dart
Loading
Success
Failure
```

## Example Widgets

```dart
BlocBuilder<MovieCubit, Response<List<Movie>>>
```

---

# Reactive Programming Concepts

# State as Source of Truth

Flutter applications are declarative.

The UI is rebuilt from state.

```text
State changes
      ↓
Framework rebuilds widgets
      ↓
UI reflects current state
```

---

# Scoped Rebuilds

The project demonstrates rebuild optimization using:

```dart
context.select()
```

This allows widgets to rebuild only when a specific property changes.

This is important for:

- performance
- scalability
- avoiding unnecessary rebuilds

---

# Separation of Concerns

The project separates responsibilities into layers.

## UI Layer

Responsible for:

- rendering widgets
- handling user interactions
- listening to state

---

## State Layer

Responsible for:

- business logic
- state transitions
- orchestration

---

## Service Layer

Responsible for:

- HTTP requests
- data fetching
- JSON parsing

---

# Architectural Comparisons

Many Flutter concepts resemble Android architectures.

| Flutter | Android |
|---|---|
| Provider | ViewModel |
| ChangeNotifier | LiveData |
| Cubit | Simplified MVI/ViewModel |
| BlocBuilder | StateFlow observer |
| StatefulWidget | Local Compose state |
| ValueNotifier | MutableState |

---

# Learning Goals

This repository focuses on understanding:

- Widget lifecycle
- Declarative UI
- Rebuild mechanics
- Dependency injection
- Shared state
- Reactive architecture
- Separation of concerns
- Async state management
- Navigation architecture
- Scalable Flutter architecture

---

# Future Improvements

Possible future additions:

- Full BLoC
- Riverpod
- Redux
- MobX
- Clean Architecture
- Repository pattern
- Offline caching
- Unit tests
- Widget tests
- Integration tests

---

# Educational Purpose

This repository was built primarily for:

- Learning
- Experimentation
- Architectural comparison
- Flutter fundamentals practice
- Understanding reactive programming
- Studying scalable state management solutions

---

# Conclusion

This project progressively demonstrates how Flutter state management evolves from:

```text
setState()
```

into more scalable reactive architectures such as:

```text
Provider → MultiProvider → Cubit/BLoC
```

The examples aim to provide both practical implementation experience and architectural understanding for modern Flutter development.

