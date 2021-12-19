part of module_todo_widgets;

class TodoListItem extends GetView<TodosControllerS> {
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: Card(
        elevation: 2.0,
        child: InkWell(
          onTap: _tapTodoItem,
          onLongPress: _longPressTodoItem,
          child: Center(
            child: LI(
              title: Obx(
                () => Text(
                  todo.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              subtitle: Text(todo.description),
              details: Text(todo.createdAt.format(short: true)),
              leading: GetBuilder<TodosControllerS>(
                assignId: true,
                id: TodosControllerID.DELETE_MODE,
                builder: (controller) => AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isDeleteMode
                      ? GetBuilder<TodosControllerS>(
                          assignId: true,
                          id: TodosControllerID.SELECT(todo.id),
                          builder: (controller) {
                            return Checkbox(
                              value: controller.isSelectedForDeleting(todo.id),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              onChanged: (state) => controller
                                  .toggleSelectionForDeleting(todo.id, state),
                            );
                          },
                        )
                      : null,
                ),
              ),
              trailing: GetBuilder<TodosControllerS>(
                assignId: true,
                id: TodosControllerID.DELETE_MODE,
                builder: (controller) => AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isDeleteMode
                      ? null
                      : IconButton(
                          onPressed: () {
                            todo.toggleDone();
                          },
                          icon: Obx(
                            () => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              child: !todo.done
                                  ? const Icon(Icons.done)
                                  : const Icon(Icons.done_all),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _longPressTodoItem() {
    if (!controller.isDeleteMode) {
      controller.openDeleteMode(todo.id);
    }
  }

  void _tapTodoItem() async {
    if (controller.isDeleteMode) {
      controller.toggleSelectionForDeleting(todo.id);
    } else {
      await Get.toNamed(Routes.updateTodo(todo.id));
    }
  }
}

// class TodoListItem extends GetView<TodosController> {
//   const TodoListItem({Key? key, required this.todo}) : super(key: key);

//   final Todo todo;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(32.0),
//       child: Card(
//         elevation: 2.0,
//         child: InkWell(
//           onTap: () {
//             if (controller.isDeleteMode) {
//               controller.toggleSelectionForDeleting(todo.id);
//             } else {
//               Get.toNamed(Routes.updateTodo(todo.id));
//             }
//           },
//           onLongPress: () {
//             if (!controller.isDeleteMode) {
//               controller.openDeleteMode(todo.id);
//             }
//           },
//           child: Center(
//             child: LI(
//               title: Obx(
//                 () => Text(
//                   todo.label,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     decoration:
//                         todo.done.value ? TextDecoration.lineThrough : null,
//                   ),
//                 ),
//               ),
//               subtitle: Text(todo.description),
//               leading: Obx(
//                 () => AnimatedSize(
//                   duration: Duration(milliseconds: 250),
//                   child: controller.isDeleteMode
//                       ? Checkbox(
//                           value: controller.isSelectedForDeleting(todo.id),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(99.0),
//                           ),
//                           onChanged: (state) => controller
//                               .toggleSelectionForDeleting(todo.id, state),
//                         )
//                       : null,
//                 ),
//               ),
//               trailing: Obx(
//                 () => AnimatedSize(
//                   duration: Duration(milliseconds: 250),
//                   child: controller.isDeleteMode
//                       ? null
//                       : IconButton(
//                           onPressed: () {
//                             todo.toggleDone();
//                           },
//                           icon: Obx(
//                             () => AnimatedSwitcher(
//                               duration: const Duration(milliseconds: 150),
//                               child: !todo.done.value
//                                   ? const Icon(Icons.done)
//                                   : const Icon(Icons.done_all),
//                             ),
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LI extends StatelessWidget {
  const LI({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.details,
  }) : super(key: key);

  final Widget? leading;
  final Widget? trailing;
  final Widget? subtitle;
  final Widget? details;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!,
                  child: title,
                ),
                if (subtitle != null)
                  DefaultTextStyle(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2!,
                    child: subtitle!,
                  ),
                if (details != null)
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!,
                    child: details!,
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
