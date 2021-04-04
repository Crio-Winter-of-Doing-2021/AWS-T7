import 'package:flutter/material.dart';
import 'package:frontend/provider/task_provider.dart';
import 'package:frontend/style/app_theme.dart';
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
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(54),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton(
                        value: provider.currentFilter,
                        items: provider.filters
                            .map<DropdownMenuItem<String>>(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Center(child: Text(item)),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          provider.changeFilter(val);
                        },
                        underline: Center(),
                        iconEnabledColor: AppTheme.accentColor,
                        style: TextStyle(
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: provider.state == ViewState.Loading
                      ? Loader()
                      : provider.list.length == 0
                          ? Center(
                              child: Text("No Items"),
                            )
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
        },
      ),
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
