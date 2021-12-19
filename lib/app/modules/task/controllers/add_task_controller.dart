part of module_task_controllers;

class AddTaskController extends GetxController {
  final todosController = Get.find<TasksController>();

  final selectedColor = Colors.pinkAccent[400]!.obs;
  final time = Rx<TimeOfDay?>(null);

  void addTask({
    required String label,
    required String description,
  }) {
    todosController.add(Task.initial(
      id: nanoid(7),
      label: label,
      description: description,
      startAt: time.value ?? const TimeOfDay(hour: 0, minute: 0),
      color: selectedColor.value,
    ));
  }

  void updateTask(
    Task initialTask, {
    required String label,
    required String description,
  }) {
    todosController.updateItem(initialTask.copyWith(
      startAt: time.value,
      color: selectedColor.value,
      description: description,
      label: label,
    ));
  }

  void openDatePicker() async {
    time.value = await showTimePicker(
      context: Get.overlayContext ?? Get.context!,
      initialTime: const TimeOfDay(hour: 0, minute: 0),

      // firstDate: DateTime.now(),
      // lastDate: DateTime.now()..add(const Duration(days: 7)),
    );
  }

  void openColorPicker() async {
    final selected = await showColorPickerDialog(
      Get.overlayContext ?? Get.context!,
      selectedColor.value,
      customColorSwatchesAndNames: colorsNameMap,
    );
    log(selected.hex);
    selectedColor.value = selected;
  }
}
