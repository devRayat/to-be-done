part of module_todo_controllers;

abstract class TodosControllerID {
  TodosControllerID._();

  static const SELECT_ALL = 'select_all';

  static const SELECTED = 'selected';

  static String SELECT(String id) => 'select_$id';

  static const DELETE_MODE = 'delete_mode';

  static const TODOS = 'todos';
}

class TodosControllerS extends GetxController {
  var _todos = <Todo>[];
  var _isDeleteMode = false;
  var _selectedToDelete = <String>[];

  List<Todo> get items => _todos;
  List<String> get selectedToDelete => _selectedToDelete;
  bool get isDeleteMode => _isDeleteMode;
  bool get isSelectedAllForDeleting =>
      _selectedToDelete.length == _todos.length;

  late final Worker _todoWorker;
  late final Worker _deleteModeWorker;

  final _todoBox = Get.find<DatabaseService>().todoBox;

  @override
  void onInit() {
    super.onInit();

    _todos = todoMocks;

    ever<List<Todo>>(
      _todos.obs,
      (_) => log('Todos changed, length: ${_.length}'),
    );

    ever<bool>(
      _isDeleteMode.obs,
      (_) => log('Delete mode: $_'),
    );

    ever<bool>(_isDeleteMode.obs, (_) {
      _selectedToDelete.clear();
    }, condition: !_isDeleteMode);

    ever<List<String>>(
      _selectedToDelete.obs,
      (selectedToDelete) {
        log('Is selected all fro deleting: ${selectedToDelete.length == _todos.length}');
      },
    );
  }

  void selectAllForDeleting() {
    if (isDeleteMode) {
      _selectedToDelete = items.map((todo) => todo.id).toList();
      update([
        TodosControllerID.SELECT_ALL,
        TodosControllerID.SELECTED,
        ..._todos.map((t) => TodosControllerID.SELECT(t.id)),
      ]);
    }
  }

  void unselectAllForDeleting() {
    if (isDeleteMode) {
      _selectedToDelete.clear();
      update([
        TodosControllerID.SELECT_ALL,
        TodosControllerID.SELECTED,
        ..._todos.map((t) => TodosControllerID.SELECT(t.id)),
      ]);
    }
  }

  void toggleSelectAllForDeleting([bool? toggleState]) {
    if (toggleState ?? _selectedToDelete.isEmpty) {
      log('selecting all');
      selectAllForDeleting();
    } else {
      log('deselecting all');
      unselectAllForDeleting();
    }
  }

  bool isSelectedForDeleting(String id) => _selectedToDelete.contains(id);

  void selectForDeleting(String id) {
    if (isDeleteMode) {
      _selectedToDelete.add(id);
      update([TodosControllerID.SELECT(id), TodosControllerID.SELECTED]);
    }
  }

  void unselectForDeleting(String id) {
    if (isDeleteMode) {
      _selectedToDelete.remove(id);
      update([TodosControllerID.SELECT(id), TodosControllerID.SELECTED]);
    }
  }

  void toggleSelectionForDeleting(String id, [bool? toggleState]) {
    if (toggleState ?? !_selectedToDelete.contains(id)) {
      selectForDeleting(id);
    } else {
      unselectForDeleting(id);
    }
  }

  // Worker onDeleteModeChange(void Function(bool) changer) {
  //   return ever<bool>(_isDeleteMode, changer);
  // }

  void openDeleteMode(String id) {
    _isDeleteMode = true;
    _selectedToDelete.add(id);
    update([TodosControllerID.DELETE_MODE, TodosControllerID.SELECT(id)]);
  }

  void closeDeleteMode() {
    _isDeleteMode = false;
    update([TodosControllerID.DELETE_MODE]);
  }

  // void toggleDeleteMode() {
  //   _isDeleteMode();
  // }

  // void changeDeleteMode(bool? state) {
  //   _isDeleteMode.value = state ?? false;
  // }

  Future<void> add(Todo newTodo) async {
    await _todoBox.put(newTodo.id, newTodo);

    _todos.add(newTodo);
    update([TodosControllerID.TODOS]);
  }

  Future<void> updateItem(Todo updatedTodo) async {
    await _todoBox.put(updatedTodo.id, updatedTodo);

    _todos = _todos.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      }
      return todo;
    }).toList();
    update([TodosControllerID.TODOS]);
  }

  Future<void> remove(Todo _todo) async {
    await _todo.delete();
    _todos.removeWhere((todo) => todo.id == _todo.id);
    update([TodosControllerID.TODOS]);
  }

  // void operUpdatingModal(int id) async {
  //   await Get.bottomSheet(
  //     TodoSheet.update(todo: _todos[id]),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
  //     ),
  //     elevation: 5.0,
  //     backgroundColor: Colors.teal[50],
  //     isDismissible: true,
  //     isScrollControlled: true,
  //     enableDrag: true,
  //   );
  // }

  // void openAddingModal() async {
  //   try {
  //     await Get.bottomSheet(
  //       TodoSheet.add(),
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
  //       ),
  //       elevation: 5.0,
  //       backgroundColor: Colors.teal[50],
  //       isDismissible: true,
  //       isScrollControlled: true,
  //       enableDrag: true,
  //     );
  //   } catch (e, s) {
  //     log('error:', error: e, stackTrace: s);
  //   }
  // }

  @override
  void dispose() {
    _todoWorker.dispose();
    _deleteModeWorker.dispose();
    super.dispose();
  }
}

class TodosController extends GetxController {
  final _todos = <Todo>[].obs;
  final _isDeleteMode = false.obs;
  final _selectedToDelete = <String>[].obs;

  List<Todo> get items => _todos;
  List<String> get selectedToDelete => _selectedToDelete;
  bool get isDeleteMode => _isDeleteMode.value;
  bool get isSelectedAllForDeleting =>
      _selectedToDelete.length == _todos.length;

  late final Worker _todoWorker;
  late final Worker _deleteModeWorker;

  @override
  void onInit() {
    super.onInit();

    _todos.value = todoMocks;

    ever<List<Todo>>(
      _todos,
      (_) => log('Todos changed, length: ${_.length}'),
    );

    ever<bool>(
      _isDeleteMode,
      (_) => log('Delete mode: $_'),
    );

    ever<bool>(_isDeleteMode, (_) {
      _selectedToDelete.clear();
    }, condition: !_isDeleteMode.value);

    ever<List<String>>(
      _selectedToDelete,
      (selectedToDelete) {
        log('Is selected all fro deleting: ${selectedToDelete.length == _todos.length}');
      },
    );
  }

  void selectAllForDeleting() {
    if (isDeleteMode) {
      _selectedToDelete.value = items.map((todo) => todo.id).toList();
    }
  }

  void unselectAllForDeleting() {
    if (isDeleteMode) {
      _selectedToDelete.clear();
    }
  }

  void toggleSelectAllForDeleting([bool? toggleState]) {
    if (toggleState ?? _selectedToDelete.isEmpty) {
      log('selecting all');
      selectAllForDeleting();
    } else {
      log('deselecting all');
      unselectAllForDeleting();
    }
  }

  bool isSelectedForDeleting(String id) => _selectedToDelete.contains(id);

  void selectForDeleting(String id) {
    if (isDeleteMode) {
      _selectedToDelete.add(id);
    }
  }

  void unselectForDeleting(String id) {
    if (isDeleteMode) {
      _selectedToDelete.remove(id);
    }
  }

  void toggleSelectionForDeleting(String id, [bool? toggleState]) {
    if (toggleState ?? !_selectedToDelete.contains(id)) {
      selectForDeleting(id);
    } else {
      unselectForDeleting(id);
    }
  }

  Worker onDeleteModeChange(void Function(bool) changer) {
    return ever<bool>(_isDeleteMode, changer);
  }

  void openDeleteMode(String id) {
    _isDeleteMode.value = true;
    _selectedToDelete.add(id);
  }

  void closeDeleteMode() => _isDeleteMode.value = false;

  void toggleDeleteMode() => _isDeleteMode.toggle();

  void changeDeleteMode(bool? state) {
    _isDeleteMode.value = state ?? false;
  }

  void add(Todo newTodo) {
    _todos.add(newTodo);
  }

  void updateItem(Todo updatedTodo) {
    _todos.value = _todos.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      }
      return todo;
    }).toList();
  }

  void remove(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void operUpdatingModal(int id) async {
    await Get.bottomSheet(
      TodoSheet.update(todo: _todos[id]),
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

  void openAddingModal() async {
    try {
      await Get.bottomSheet(
        TodoSheet.add(),
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
    _todoWorker.dispose();
    _deleteModeWorker.dispose();
    super.dispose();
  }
}
