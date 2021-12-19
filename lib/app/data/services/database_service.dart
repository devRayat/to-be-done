part of services;

class DatabaseService extends GetxService {
  late final Box<int> pageControllerBox;
  late final Box<Task> taskBox;
  late final Box<Todo> todoBox;

  Future<DatabaseService> init() async {
    await Hive.initFlutter();

    Hive
      // Core adapters
      ..registerAdapter(ColorAdapter())
      ..registerAdapter(DurationAdapter())
      ..registerAdapter(TimeOfDayAdapter())
      // Custom Adapters
      ..registerAdapter(TaskAdapter())
      ..registerAdapter(TodoAdapter());

    todoBox = await Hive.openBox<Todo>('todos');
    taskBox = await Hive.openBox<Task>('tasks');
    pageControllerBox = await Hive.openBox<int>('pageIndex');

    return this;
  }
}
