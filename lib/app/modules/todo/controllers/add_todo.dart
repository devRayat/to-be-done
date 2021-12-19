part of module_todo_controllers;

class AddTodoController extends GetxController {
  final todosController = Get.find<TodosController>();

  final selectedColor = Colors.pinkAccent[400]!.obs;
  final time = Rx<DateTime?>(null);

  void addTodo({
    required String label,
    required String description,
  }) {
    todosController.add(Todo.initial(
      id: nanoid(6),
      label: label,
      description: description,
      beforeTime: time.value,
      color: selectedColor.value,
    ));
  }

  void updateTodo(
    Todo initialTodo, {
    required String label,
    required String description,
  }) {
    todosController.updateItem(initialTodo.copyWith(
      beforeTime: time.value,
      color: selectedColor.value,
      description: description,
      label: label,
    ));
  }

  void openDatePicker() async {
    time.value = await showDatePicker(
      context: Get.overlayContext ?? Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now()..add(const Duration(days: 7)),
    );
  }

  Future<Color> openColorPicker() async {
    final selected = await showColorPickerDialog(
      Get.overlayContext ?? Get.context!,
      selectedColor.value,
      customColorSwatchesAndNames: colorsNameMap,
    );
    log(selected.hex);
    selectedColor.value = selected;
    return selected;
  }
}
