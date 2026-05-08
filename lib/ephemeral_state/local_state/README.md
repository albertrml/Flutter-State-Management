# `ephemeral_state/README.md`

# UI/Local State

## Overview

This example demonstrates Flutter's simplest state management technique:

- Local widget state
- `StatefulWidget`
- `setState()`

This type of state is called:

- Ephemeral State
- Local State
- UI State

It belongs only to a single widget.

---

# Architecture

```text
StatefulWidget
 └── Internal mutable state
        └── setState()
```

The widget owns its own state.

---

# StatefulWidget

Example:

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}
```

`StatefulWidget` creates a mutable `State` object.

---

# Internal State

```dart
class _CounterState extends State<Counter> {
  int counter = 0;
}
```

The state exists only while the widget remains in memory.

---

# Updating UI with setState()

```dart
void increment() => setState(() => counter++);
void decrement() => setState(() => counter--);
void reset() => setState(() => counter = 0);
```

## What happens?

- Flutter marks the widget as dirty.
- The widget rebuilds.
- The UI reflects the new state.

---

# Rebuild Cycle

When `setState()` is called:

```text
State changes
      ↓
setState()
      ↓
Widget rebuild
      ↓
Updated UI
```

Flutter efficiently redraws only necessary parts.

---

# Characteristics

Ephemeral state is:

- Temporary
- Local
- UI-oriented
- Short-lived

Examples:

- Selected tab
- Animation progress
- Text field focus
- Toggle state
- Counter value

---

# Advantages

- Extremely simple.
- Minimal boilerplate.
- Perfect for UI-only logic.
- Fast development.

---

# Disadvantages

- Cannot easily share state.
- Difficult to scale.
- Tight coupling between UI and state.

---

# Recommended Usage

Use ephemeral state when:

- The state belongs to one widget.
- No other widget needs the data.
- The state is temporary.

Avoid using it for:

- Global application state.
- Shared business logic.
- Complex reactive flows.

---