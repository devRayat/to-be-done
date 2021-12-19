part of module_todo_views;

class TodoSheet extends GetView<AddTodoController> {
  final bool _update;
  final Todo? todo;

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  TodoSheet._(this._update, this.todo, {Key? key}) : super(key: key) {
    if (todo != null) {
      final prev = todo!;
      _titleController.text = prev.label;
      _descController.text = prev.description;
      controller.selectedColor.value = prev.color;
      controller.time.value = prev.beforeTime;
    }
  }

  factory TodoSheet.add({Key? key}) => TodoSheet._(false, null, key: key);

  factory TodoSheet.update({Key? key, required Todo todo}) =>
      TodoSheet._(true, todo, key: key);

  final _formKey = GlobalKey<FormState>(debugLabel: 'form');
  // final todosController = Get.find<TodosController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!_update ? 'Add Todo' : todo!.label),
        leading: BackButton(
          // color: Colors.black,
          onPressed: () => Get.back<bool>(result: false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Todo',
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
                OutlinedButton(
                  onPressed: () async {
                    final primary = await controller.openColorPicker();
                    Get.changeTheme(
                      Theme.of(context).copyWith(
                        primaryColor: Colors.red,
                      ),
                    );
                    // Get.reload();
                  },
                  child: const Text('Pick Color'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 20.0,
        notchMargin: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.back<bool>(result: false);
                  },
                  child: const Text('Cancel'),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    if (_update) {
                      controller.updateTodo(
                        todo!,
                        label: _titleController.text,
                        description: _descController.text,
                      );
                    } else {
                      controller.addTodo(
                        label: _titleController.text,
                        description: _descController.text,
                      );
                    }
                    // Navigator.of(context).pop();
                    Get.back<bool>(result: true);
                  },
                  child: const Text('Save'),
                  style: TextButton.styleFrom(
                    primary: Colors.greenAccent[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
