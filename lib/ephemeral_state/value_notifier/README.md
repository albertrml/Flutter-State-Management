# ValueNotifier — Ephemeral State Management

This example demonstrates reactive state management using Flutter's `ValueNotifier` and `ValueListenableBuilder`.

The application simulates a visual transition between:

- Day mode
- Night mode

The screen background changes dynamically using animated gradients.

---

# Goal

This example was created to demonstrate:

- Reactive UI updates
- Local state management
- Ephemeral state
- Rebuild behavior without `setState()`
- Lightweight reactive programming in Flutter

---

# Why ValueNotifier?

`ValueNotifier<T>` is one of Flutter's simplest reactive state management solutions.

It is useful when:

- the state is small
- only one value needs to be observed
- the state belongs to a single screen
- global state management is unnecessary

---

# Architecture

## State

```dart
enum SkyMode {
  day,
  night,
}
```

The application has only two possible states.

---

## Controller

```dart
final ValueNotifier<SkyMode> mode =
    ValueNotifier(SkyMode.day);
```

The controller stores the current state reactively.

Whenever:

```dart
mode.value = ...
```

changes, listeners are notified automatically.

---

# Reactive UI

The UI listens using:

```dart
ValueListenableBuilder
```

Example:

```dart
ValueListenableBuilder(
  valueListenable: controller.mode,
  builder: (ctx, mode, _) {
    ...
  },
)
```

Whenever the notifier changes:

1. the builder executes again
2. the widget rebuilds
3. the UI updates automatically

No `setState()` is required.

---

# State Flow

```text
User presses button
        ↓
controller.toggle()
        ↓
mode.value changes
        ↓
ValueNotifier notifies listeners
        ↓
ValueListenableBuilder rebuilds
        ↓
UI updates automatically
```

---

# Animated Transitions

The background transition is animated using:

```dart
AnimatedContainer
```

Flutter interpolates the gradient changes automatically.

---

# Why This Is Ephemeral State

This example represents **Ephemeral State** because:

- the state belongs to a single screen
- it is temporary
- it is not shared globally
- it does not persist between app sessions

---

# Learning Objectives

This example teaches:

- reactive programming fundamentals
- local reactive state
- Flutter rebuild cycle
- listener-based architecture
- lightweight state management

---

# Key Concepts

## ValueNotifier

Stores a reactive value.

---

## ValueListenableBuilder

Rebuilds widgets automatically when the value changes.

---

## dispose()

Prevents memory leaks by releasing listeners.

---