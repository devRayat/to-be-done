part of module_task_widgets;

class TaskListItem extends StatelessWidget {
  const TaskListItem({Key? key, required this.task}) : super(key: key);

  // final _progress = 0.0.obs;

  final Task task;

  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: 10,
      valueColor: const AlwaysStoppedAnimation(Colors.pink),
      backgroundColor: Colors.transparent,
      borderColor: Colors.red,
      borderWidth: 1.0,
      direction: Axis.horizontal,
      center: Text("Loading..."),
    );
  }
}

class _TaskItemWithoutProgress extends StatelessWidget {
  const _TaskItemWithoutProgress({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      child: Card(
        elevation: 2.0,
        color: Colors.transparent,
        child: Dismissible(
          key: ValueKey(task),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Deleting',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // widget.handleRemoved(i);
              // controller.remove(task.id);
            }
          },
          child: ListTile(
            tileColor: Colors.transparent,
            title: Text(task.label),
            subtitle: Text(task.description),
            isThreeLine: true,
            trailing: IconButton(
              onPressed: () {
                // controller.operUpdatingModal(task);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }
}
