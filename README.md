# to_be_done

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Models

```dart
class Todo {
    final int id;
    final String label;
    final String description;
    final bool isDone;
    final int color;
    final DateTime createdAt;
    final DateTime beforeTime;
}

class Task {
    final int id;
    final String label;
    final String description;
    final int color;
    final DateTime createdAt;
    final int startAt;
    final int duration;
}
```

# Pages

* Todo
    * todos
    * add todo

* Task
    * tasks
    * add task
