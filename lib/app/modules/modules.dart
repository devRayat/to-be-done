library modules;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:to_be_done/app/data/services/services.dart';
import 'package:to_be_done/app/modules/task/controllers/controllers.dart';
import 'package:to_be_done/app/modules/task/views/views.dart';
import 'package:to_be_done/app/modules/todo/todo.dart';

Future<void> initControllers() async {
  // Get.lazyPut<TodosController>(() => TodosController(), fenix: true);
  Get.lazyPut<TodosControllerS>(() => TodosControllerS(), fenix: true);
  Get.lazyPut<AddTodoController>(() => AddTodoController(), fenix: true);

  Get.lazyPut<TasksController>(() => TasksController(), fenix: true);
  Get.lazyPut<AddTaskController>(() => AddTaskController(), fenix: true);
}

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key) {
    init();
  }

  @mustCallSuper
  void init() {
    var storedPageIndex = 0;
    if (_pageBox.containsKey(0)) {
      storedPageIndex = _pageBox.get(0)!;
    }
    _pageController = PageController(initialPage: storedPageIndex);
  }

  late final PageController _pageController;

  final _pageBox = Get.find<DatabaseService>().pageControllerBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          TodoScreen(),
          TaskScreen(),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return BottomNavyBar(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            selectedIndex: _pageController.page?.toInt() ?? 0,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.list),
                title: const Text('Todos'),
              ),
              BottomNavyBarItem(
                icon: _pageController.page != 0
                    ? const Icon(Icons.task_rounded)
                    : const Icon(Icons.task_outlined),
                activeColor: Colors.orangeAccent,
                title: const Text('Tasks'),
              ),
            ],
            onItemSelected: (page) async {
              await Future.wait([
                _pageController.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                ),
                _pageBox.put(0, page),
              ]);
            },
          );
        },
      ),
    );
  }
}
