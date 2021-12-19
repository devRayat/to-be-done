part of module_task_views;

class TaskSheet extends GetView<AddTaskController> {
  final bool _update;
  final Task? todo;

  TaskSheet._(this._update, this.todo, {Key? key}) : super(key: key) {
    _titleController = TextEditingController();
    _descController = TextEditingController();

    if (todo != null) {
      final prev = todo!;
      _titleController.text = prev.label;
      _descController.text = prev.description;
      controller.selectedColor.value = prev.color;
      controller.time.value = prev.startAt;
    }
  }

  factory TaskSheet.add({Key? key}) => TaskSheet._(false, null, key: key);

  factory TaskSheet.update({Key? key, required Task todo}) =>
      TaskSheet._(true, todo, key: key);

  final _formKey = GlobalKey<FormState>(debugLabel: 'form');

  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  // final todosController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: 'What to do?',
                  isDense: true,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Description',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: 'How to do?',
                  isDense: true,
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: controller.openDatePicker,
                child: const Text('Pick Time'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.openColorPicker,
                      child: const Text('Pick Color'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Obx(
                    () => ColorIndicator(color: controller.selectedColor.value),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: FloatingActionButton(
                  onPressed: () {
                    if (_update) {
                      controller.updateTask(
                        todo!,
                        label: _titleController.text,
                        description: _descController.text,
                      );
                    } else {
                      controller.addTask(
                        label: _titleController.text,
                        description: _descController.text,
                      );
                    }
                    // Navigator.of(context).pop();
                    Get.back();
                  },
                  child: Icon(_update ? Icons.update : Icons.add),
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
