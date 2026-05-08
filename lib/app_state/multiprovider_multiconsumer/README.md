# `multiprovider_multiconsumer/README.md`

# MultiProvider and MultiConsumer

## Overview

This example demonstrates how Flutter manages multiple independent states using:

- `MultiProvider`
- `Consumer`
- `context.watch()`
- `context.read()`
- `context.select()`

The example creates an RGB color generator.

Each color channel:

- Red
- Green
- Blue

has its own independent state.

---

# Architecture

```text
MultiProvider
 ├── Red Channel State
 ├── Green Channel State
 └── Blue Channel State

Widgets:
 ├── Color Preview
 └── RGB Sliders
```

Each provider controls only one responsibility.

---

# State Object

```dart
class ColorChannel extends ChangeNotifier {
  double _value = 0;

  double get value => _value;

  set value(double newValue) {
    _value = newValue;
    notifyListeners();
  }
}
```

## Responsibilities

- Stores channel value.
- Notifies listeners.
- Encapsulates state logic.

---

# MultiProvider

The providers are registered together:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (_) => ColorChannel(ChannelType.red),
    ),
    ChangeNotifierProvider(
      create: (_) => ColorChannel(ChannelType.green),
    ),
    ChangeNotifierProvider(
      create: (_) => ColorChannel(ChannelType.blue),
    ),
  ],
  child: Scaffold(...),
)
```

## Why use MultiProvider?

Without it:

```dart
Provider(
  child: Provider(
    child: Provider(...)
  )
)
```

would create deep nesting.

`MultiProvider` improves readability.

---

# Independent State Management

Each slider controls a different provider.

Example:

```dart
MyColorSlider(channel: ChannelType.red)
```

The widget accesses only the necessary provider.

This avoids coupling unrelated state.

---

# Reactive Updates

Widgets rebuild automatically when providers notify listeners.

Example:

```dart
final channel = context.watch<T>(); // Where T is a ColorChannel 
```

When `notifyListeners()` is called:

- The listening widget rebuilds.
- The UI updates automatically.

---

# MultiConsumer

`Consumer3` allows rebuilding the specific widget regions when one of the three state is changed.

Example:

```dart
    Consumer3<RedChannel, GreenChannel, BlueChannel>(
      builder: (ctx, r, g, b, _) => Center(
      child: Container(
        // Combined application state.
        color: Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1),
    ),
  )
)
```

## Benefits

- More granular rebuilds.
- Better performance.
- Cleaner separation.

---

# RGB Color Composition

The final color is composed from all providers:

```dart
Color.fromRGBO(
  r.toInt(), 
  g.toInt(), 
  b.toInt(), 
  1
)
```

The preview widget depends on multiple states simultaneously.

---

# Advantages

- Better scalability.
- Clear separation of responsibilities.
- Modular state.
- Easier maintenance.

---

# Disadvantages

- More boilerplate.
- Requires understanding provider scopes.
- More complex than local state.

---

# Recommended Usage

Use this pattern when:

- Multiple independent states exist.
- Widgets share data across the tree.
- State complexity grows.

---

# Concepts Learned

- `MultiProvider`
- `Consumer`
- Independent state containers
- Scoped rebuilds
- Reactive UI
- State modularization

---