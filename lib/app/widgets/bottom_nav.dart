// part of widgets;

// class BottomNavigation extends StatelessWidget {
//   const BottomNavigation({
//     Key? key,
//     this.currentIndex = 0,
//     required this.onTap,
//   }) : super(key: key);

//   final int currentIndex;
//   final void Function(int) onTap;

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavyBar(
//       items: [
//         BottomNavyBarItem(
//           icon: const Icon(Icons.list),
//           title: const Text('Todos'),
//         ),
//         BottomNavyBarItem(
//           icon: currentIndex != 0
//               ? const Icon(Icons.task_rounded)
//               : const Icon(Icons.task_outlined),
//           activeColor: Colors.orangeAccent,
//           title: const Text('Tasks'),
//         ),
//       ],
//       selectedIndex: currentIndex,
//       onItemSelected: onTap,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.grey[350]!,
//   //           blurRadius: 5,
//   //           spreadRadius: 5.0,
//   //         )
//   //       ],
//   //     ),
//   //     child: BottomNavigationBar(
//   //       items: const [
//   //         BottomNavigationBarItem(
//   //           icon: Icon(Icons.list),
//   //           label: 'Todos',
//   //         ),
//   //         BottomNavigationBarItem(
//   //           icon: Icon(Icons.task_outlined),
//   //           activeIcon: Icon(Icons.task_rounded),
//   //           label: 'Tasks',
//   //         ),
//   //       ],
//   //       backgroundColor: Colors.white,
//   //       currentIndex: currentIndex,
//   //       onTap: (index) {
//   //         onTap?.call(index);
//   //       },
//   //     ),
//   //   );
//   // }
// }
