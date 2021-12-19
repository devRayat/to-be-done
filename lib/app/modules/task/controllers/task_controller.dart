part of module_task_controllers;

class TasksController extends GetxController {
  final _tasks = <Task>[].obs;
  final _taskBox = Get.find<DatabaseService>().taskBox;

  List<Task> get items => _tasks;

  late final Worker _taskWorker;

  @override
  void onInit() {
    super.onInit();
    _tasks.value = _taskBox.values.toList();

    _taskWorker = ever<List<Task>>(
      _tasks,
      (_) => log('Tasks changed, length: ${_.length}'),
    );
  }

  Future<void> add(Task newTask) async {
    await _taskBox.put(newTask.id, newTask);

    _tasks.add(newTask);
  }

  Future<void> updateItem(Task updatedTask) async {
    _tasks.value = _tasks.map((task) {
      if (task.id == updatedTask.id) {
        return updatedTask;
      }
      return task;
    }).toList();

    await _taskBox.put(updatedTask.id, updatedTask);
  }

  Future<void> remove(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await _taskBox.delete(id);
  }

  Future<void> operUpdatingModal(int id) async {
    await Get.bottomSheet(
      TaskSheet.update(todo: _tasks[id]),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      elevation: 5.0,
      backgroundColor: Colors.teal[50],
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  Future<void> openAddingModal() async {
    try {
      await Get.bottomSheet(
        TaskSheet.add(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
        ),
        elevation: 5.0,
        backgroundColor: Colors.teal[50],
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true,
      );
    } catch (e, s) {
      log('error:', error: e, stackTrace: s);
    }
  }

  @override
  void dispose() {
    _taskWorker.dispose();
    super.dispose();
  }
}
