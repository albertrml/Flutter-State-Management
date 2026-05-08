# `lifting_state_up/README.md`

# Lifting State Up

## Overview

This example demonstrates the **Lifting State Up** pattern in Flutter.

In this approach:

- A parent widget owns the shared state.
- Child widgets receive data and callbacks.
- State changes happen in one centralized place.
- Widgets rebuild when the parent updates its state.

This is one of the simplest and most important state management techniques in Flutter.

---

# Architecture

```text
LiftingStateUp (Parent Widget)
 ├── Stores state
 ├── Updates state
 └── Passes data + callbacks to children
        ├── Chart Widget
        └── Slider Widget
```

The parent widget becomes the "single source of truth".

---

# Technical Explanation

## Shared State

The application stores the state in a parent widget.

Example:

```dart
class MySchedule extends ChangeNotifier {
  double _stateManagementTime = 0.5;

  double get stateManagementTime => _stateManagementTime;

  set stateManagementTime(double newValue) {
    _stateManagementTime = newValue;
    notifyListeners();
  }
}
```

### Important Concepts

- `ChangeNotifier` provides reactive state updates.
- `notifyListeners()` informs widgets that the state changed.
- Widgets listening to this object rebuild automatically.

---

# Using Provider

The state object is injected into the widget tree:

```dart
ChangeNotifierProvider(
  create: (_) => MySchedule(),
  child: Scaffold(...),
)
```

This makes `MySchedule` available to all descendants.

---

# Reading State

Widgets can observe changes using:

```dart
  final stateManagementTime = ctx.select<MySchedule, double>(
    (schedule) => schedule.stateManagementTime,
  );
```

## What happens?

- `select()` subscribes this widget only to changes in stateManagementTime.
- Whenever `notifyListeners()` is called, the widget rebuilds.
- The widget reacts automatically to state changes.

---

# Updating State

Inside callbacks, `read()` is preferred:

```dart
onChanged: (newValue) => ctx.read<MySchedule>().stateManagementTime = newValue,
```

## Why use `read()`?

- `read()` accesses the instance without subscribing.
- Callbacks should not trigger rebuild subscriptions.
- This avoids unnecessary rebuild dependencies.

---

# `watch()` vs `select()`

## watch()

```dart
context.watch<MySchedule>()
```

Rebuilds whenever **any** state inside `MySchedule` changes.

---

## select()

```dart
context.select<MySchedule, double>(
  (schedule) => schedule.stateManagementTime,
)
```

Rebuilds only when the selected property changes.

This is more optimized.

---

# Advantages

- Simple to understand.
- Good for small applications.
- Centralized state.
- Easy debugging.

---

# Disadvantages

- Parent widgets can become too large.
- Prop drilling may happen.
- Harder to scale in large projects.

---

# Recommended Usage

Use Lifting State Up when:

- The application is small.
- Few widgets share the state.
- Simplicity is more important than scalability.

---

# Concepts Learned

- `ChangeNotifier`
- `Provider`
- `watch()`
- `read()`
- `select()`
- Shared state
- Reactive rebuilds
- Widget tree dependency injection

---