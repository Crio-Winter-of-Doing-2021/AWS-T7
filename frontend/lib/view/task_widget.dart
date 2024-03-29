import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/task_model.dart';
import 'package:frontend/provider/task_provider.dart';
import 'package:frontend/view/create_task_widget.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskWidget({Key key, this.task, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(task.name),
                _buildOptions(context, task),
              ],
            ),
            if (task.output != null && task.output.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(task.output),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context, TaskModel task) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => _checkStatus(context),
          child: Text('Check status'),
        ),
        SizedBox(width: 8),
        Chip(
          backgroundColor: Colors.grey[100],
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              task.state,
              style: TextStyle(),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: () => _cancel(context),
          icon: Icon(Icons.cancel),
        ),
        IconButton(
          onPressed: () => _update(context),
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }

  void _cancel(
    BuildContext context,
  ) {
    Provider.of<TaskProvider>(context, listen: false).canceltask(task);
  }

  void _checkStatus(
    BuildContext context,
  ) {
    Provider.of<TaskProvider>(context, listen: false).checkStatus(task);
  }

  void _update(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: CreateTaskWidget(
            task: task,
          ),
        ),
      ),
    );
  }
}
