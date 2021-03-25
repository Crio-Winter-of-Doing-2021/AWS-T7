import 'package:flutter/material.dart';
import 'package:frontend/view/create_task_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;
  bool _expand = false;

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
  }

  void _prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      value: _expand ? 1.0 : 0.0,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AWS lambda Scheduler'),
      ),
      body: Column(
        children: [
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: CreateTaskWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_expand)
            expandController.forward();
          else
            expandController.reverse();
          _expand = !_expand;
        },
      ),
    );
  }
}
