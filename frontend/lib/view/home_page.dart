import 'package:flutter/material.dart';
import 'package:frontend/provider/task_provider.dart';
import 'package:frontend/view/create_task_widget.dart';
import 'package:frontend/view/task_widget.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _firstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstTime) {
      _firstTime = false;
      Provider.of<TaskProvider>(context, listen: false).getAllTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AWS lambda Scheduler'),
      ),
      body: Consumer<TaskProvider>(builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: provider.state == ViewState.Loading
                    ? Loader()
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskWidget(
                            task: provider.list[index],
                            index: index,
                          );
                        },
                        itemCount: provider.list.length,
                      ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showCreateDialog,
      ),
    );
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: CreateTaskWidget(),
        ),
      ),
    );
  }
}
