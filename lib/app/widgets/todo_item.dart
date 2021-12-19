// part of widgets;

// class Gas extends GetxController {}

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
//             Get.to(() => TodoSheet.update(todo: todo));
//           },
//           onLongPress: () {
//             if (!controller.isDeleteMode) {
//               controller.openDeleteMode();
//             }
//           },
//           child: Center(
//             child: LI(
//               // tileColor: todo.color,
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
//               // isThreeLine: true,
//               // onTap: () {
//               //   Get.to(() => TodoSheet.update(todo: todo));
//               // },
//               // onLongPress: () {
//               //   if (!controller.isDeleteMode) {
//               //     controller.openDeleteMode();
//               //   }
//               // },
//               leading: Obx(
//                 () => AnimatedSize(
//                   duration: Duration(milliseconds: 250),
//                   // scale: controller.isDeleteMode?1:0,
//                   child: controller.isDeleteMode
//                       ? Checkbox(
//                           value: false,
//                           onChanged: null,
//                         )
//                       : null,
//                 ),
//               ),
//               // minLeadingWidth: 20.0,
//               trailing: Obx(
//                 () => AnimatedSize(
//                   duration: Duration(milliseconds: 250),
//                   child: controller.isDeleteMode
//                       ? null
//                       : IconButton(
//                           onPressed: () {
//                             // controller.operUpdatingModal(todo.id);
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

// class LI extends StatelessWidget {
//   const LI({
//     Key? key,
//     required this.title,
//     this.subtitle,
//     this.leading,
//     this.trailing,
//   }) : super(key: key);

//   final Widget? leading;
//   final Widget? trailing;
//   final Widget? subtitle;
//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           if (leading != null) leading!,
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DefaultTextStyle(
//                   maxLines: 1,
//                   style: Theme.of(context).textTheme.subtitle1!,
//                   child: title,
//                 ),
//                 if (subtitle != null)
//                   DefaultTextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: Theme.of(context).textTheme.bodyText2!,
//                     child: subtitle!,
//                   ),
//               ],
//             ),
//           ),
//           if (trailing != null) trailing!,
//         ],
//       ),
//     );
//   }
// }
