part of module_task_views;

class TaskScreen extends GetView<TasksController> {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        titleTextStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[350],
      ),
      body: Column(
        children: [
          LiquidLinearProgressIndicator(
            value: 0.5, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(Colors
                .pink.shade500), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors
                .transparent, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.red,
            borderWidth: 1.0,
            direction: Axis
                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: const SizedBox(
              height: 150,
              width: double.infinity,
              child: Text("Loading..."),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: 1,
      //   onTap: (index) {
      //     if (index == 0) {
      //       Get.back();
      //     }
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.openAddingModal,
      //   tooltip: 'Add Task',
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.teal,
      // ),
      resizeToAvoidBottomInset: true,
    );
  }
}
