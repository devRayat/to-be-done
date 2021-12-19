part of routes;

class Pages {
  Pages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => IndexPage(),
    ),
    GetPage(
      name: Routes.ADD_TODO,
      page: () => TodoSheet.add(),
    ),
    GetPage(
      name: Routes.UPDATE_TODO,
      page: () {
        final id = Get.parameters['id'];
        log('update todo, id: $id');
        final todo = todoMocks.singleWhere((todo) => todo.id == id);
        // final todo = Get.find<TodosController>()
        //     .items
        //     .singleWhere((todo) => todo.id == id);
        return TodoSheet.update(todo: todo);
      },
    ),
    GetPage(
      name: Routes.ADD_TASK,
      page: () => TaskSheet.add(),
    ),
    GetPage(
      name: Routes.UPDATE_TASK,
      page: () {
        final id = int.parse(Get.parameters['id']!);
        final todo = Get.find<TasksController>().items[id];
        return TaskSheet.update(todo: todo);
      },
    ),
  ];
}
