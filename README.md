# `README.md`

# Flutter State Management Studies

## Overview

This project was created to study and compare different state management techniques in Flutter.

The application contains multiple examples demonstrating:

- Ephemeral State
- Lifting State Up
- Provider
- MultiProvider
- MultiConsumer
- Reactive rebuilds
- Declarative navigation using `go_router`

The goal is to understand:

- How Flutter rebuilds widgets
- How state flows through the widget tree
- Differences between local and shared state
- When each strategy should be used
- Scalability and maintainability concerns

---

# Technologies

The project uses:

- Flutter
- Dart
- Provider
- go_router

---

# Project Structure

```text
lib/
 ├── main.dart
 ├── router/
 ├── view/
 ├── ephemeral_state/
 │    ├── local_state/
 │    └── value_notifier/
 └── app_state/
      ├── lifting_state_up/
      └── multiprovider_multiconsumer/
 
```

Each folder focuses on a specific state management approach.

---

# Navigation

The application uses:

```dart
MaterialApp.router()
```

with:

```dart
go_router
```

This is the officially recommended declarative navigation approach for modern Flutter applications.

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

Navigation is performed with:

```dart
context.push('/route')
```

or:

```dart
context.go('/route')
```

---

# State Management Approaches

## 1. Ephemeral State

Uses:

- `StatefulWidget`
- `setState()`

Best for:

- Temporary UI state
- Widget-local data
- Simple interactions

Example:

- Counter

## 2. ValueNotifier

Uses:
- `ValueNotifier<T>`
- `ValueListenableBuilder()`

Best for:
- the state is small
- only one value needs to be observed
- the state belongs to a single screen
- global state management is unnecessary

Example:

- Day Shift

---

## 3. Lifting State Up

Uses:

- Parent-owned state
- Shared reactive data
- `Provider`
- `ChangeNotifier`

Best for:

- Shared state between widgets
- Medium complexity applications

Example:

- Time spent chart

---

## 4. MultiProvider and MultiConsumer

Uses:

- Multiple independent providers
- Scoped rebuilds
- Reactive composition

Best for:

- Modular applications
- Independent states
- Better scalability

Example:

- RGB color generator

---

# Architectural Concepts

## Declarative UI

Flutter rebuilds the UI from state.

```text
State changes
      ↓
Widget rebuilds
      ↓
UI updates automatically
```

---

## Reactive Programming

Widgets subscribe to state changes.

When the state changes:

```dart
notifyListeners()
```

Flutter rebuilds dependent widgets.

---

## Scoped Rebuilds

Using:

```dart
context.select()
```

allows rebuilding only widgets dependent on a specific property.

This improves performance.

---

# Learning Goals

This project focuses on understanding:

- Widget lifecycle
- Rebuild mechanics
- Dependency injection
- Shared state
- Reactive architecture
- Provider ecosystem
- Navigation architecture
- Separation of concerns

---

# Future Improvements

Possible future additions:

- BLoC
- Cubit
- Redux
- Riverpod

---

# Related Concepts

Many Flutter patterns are conceptually similar to Android architectures.

Examples:

| Flutter | Android |
|---|---|
| Provider | ViewModel |
| ChangeNotifier | LiveData |
| BLoC | MVI |
| Consumer | State observation |
| StatefulWidget | Local Compose state |

---

# Educational Purpose

This repository was built primarily for:

- Learning
- Experimentation
- Architectural comparison
- State management studies
- Flutter fundamentals practice

---