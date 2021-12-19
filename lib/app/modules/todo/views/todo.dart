part of module_todo_views;

class TodoScreen extends GetView<TodosControllerS> {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.isDeleteMode) {
          controller.closeDeleteMode();
          return SynchronousFuture(false);
        }
        return SynchronousFuture(true);
      },
      child: Scaffold(
        body: ColoredBox(
          color: Colors.grey.shade200,
          child: CustomScrollView(
            slivers: [
              GetBuilder<TodosControllerS>(
                assignId: true,
                id: TodosControllerID.DELETE_MODE,
                builder: (controller) => SliverAppBar(
                  pinned: true,
                  elevation: 4,
                  leading: controller.isDeleteMode
                      ? GetBuilder<TodosControllerS>(
                          assignId: true,
                          id: TodosControllerID.SELECT_ALL,
                          builder: (controller) {
                            return Checkbox(
                              value: controller.isSelectedAllForDeleting,
                              onChanged: controller.toggleSelectAllForDeleting,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                            );
                          })
                      : null,
                  title: GetBuilder<TodosControllerS>(
                      assignId: true,
                      id: TodosControllerID.SELECTED,
                      builder: (controller) {
                        return Text(
                          !controller.isDeleteMode
                              ? 'Todos'
                              : (controller.selectedToDelete.isEmpty
                                  ? 'Select todos'
                                  : '${controller.selectedToDelete.length} selected'),
                        );
                      }),
                  titleTextStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey[350],
                  actions: [
                    if (!controller.isDeleteMode) ...[
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.ADD_TODO);
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                        splashRadius: 24,
                      ),
                      IconButton(
                        onPressed: () async {
                          showMenu<Popup>(
                            context: context,
                            elevation: 4,
                            position: const RelativeRect.fromLTRB(
                              double.infinity,
                              12,
                              4,
                              double.infinity,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            items: const [
                              PopupMenuItem(
                                value: Popup.EDIT,
                                child: Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: Popup.SORT,
                                child: Text('Sort'),
                              ),
                              PopupMenuItem(
                                value: Popup.SETTINGS,
                                child: Text('Settings'),
                              ),
                            ],
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                        color: Colors.black,
                        splashRadius: 24,
                      ),
                    ],
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: GetBuilder<TodosControllerS>(
                  assignId: true,
                  id: TodosControllerID.TODOS,
                  builder: (controller) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final todo = todoMocks[i];
                        // final todo = controller.items[i];
                        // Get.put<Todo>(todo);

                        return TodoListItem(
                          key: ValueKey(todo.label),
                          todo: todo,
                        );
                      },
                      childCount: todoMocks.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}

// class TodoScreen extends GetView<TodosControllerS> {
//   const TodoScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         if (controller.isDeleteMode) {
//           controller.closeDeleteMode();
//           return SynchronousFuture(false);
//         }
//         return SynchronousFuture(true);
//       },
//       child: Scaffold(
//         body: ColoredBox(
//           color: Colors.grey.shade200,
//           child: CustomScrollView(
//             slivers: [
//               Obx(
//                 () => SliverAppBar(
//                   pinned: true,
//                   elevation: 4,
//                   leading: controller.isDeleteMode
//                       ? Checkbox(
//                           value: controller.isSelectedAllForDeleting,
//                           onChanged: controller.toggleSelectAllForDeleting,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(99.0),
//                           ),
//                         )
//                       : null,
//                   title: Text(
//                     !controller.isDeleteMode
//                         ? 'Todos'
//                         : (controller.selectedToDelete.isEmpty
//                             ? 'Select todos'
//                             : '${controller.selectedToDelete.length} selected'),
//                   ),
//                   titleTextStyle: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   backgroundColor: Colors.white,
//                   shadowColor: Colors.grey[350],
//                   actions: [
//                     if (!controller.isDeleteMode) ...[
//                       IconButton(
//                         onPressed: () {
//                           Get.toNamed(Routes.ADD_TODO);
//                         },
//                         icon: const Icon(Icons.add),
//                         color: Colors.black,
//                         splashRadius: 24,
//                       ),
//                       IconButton(
//                         onPressed: () async {
//                           showMenu<Popup>(
//                             context: context,
//                             elevation: 4,
//                             position: const RelativeRect.fromLTRB(
//                               double.infinity,
//                               12,
//                               4,
//                               double.infinity,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             items: const [
//                               PopupMenuItem(
//                                 value: Popup.EDIT,
//                                 child: Text('Edit'),
//                               ),
//                               PopupMenuItem(
//                                 value: Popup.SORT,
//                                 child: Text('Sort'),
//                               ),
//                               PopupMenuItem(
//                                 value: Popup.SETTINGS,
//                                 child: Text('Settings'),
//                               ),
//                             ],
//                           );
//                         },
//                         icon: const Icon(Icons.more_vert),
//                         color: Colors.black,
//                         splashRadius: 24,
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.all(8.0),
//                 sliver: Obx(
//                   () => SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, i) {
//                         final todo = todoMocks[i];
//                         // final todo = controller.items[i];
//                         // Get.put<Todo>(todo);

//                         return TodoListItem(
//                           key: ValueKey(todo.label),
//                           todo: todo,
//                         );
//                       },
//                       childCount: todoMocks.length,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         resizeToAvoidBottomInset: true,
//       ),
//     );
//   }
// }

enum Popup { SETTINGS, EDIT, SORT }
