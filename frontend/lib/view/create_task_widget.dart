import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/task_model.dart';
import 'package:frontend/provider/task_provider.dart';
import 'package:frontend/utils/helper.dart';
import 'package:provider/provider.dart';

class CreateTaskWidget extends StatefulWidget {
  final TaskModel task;

  const CreateTaskWidget({Key key, this.task}) : super(key: key);

  @override
  _CreateTaskWidgetState createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _url = TextEditingController();
  final _time = TextEditingController();
  PlatformFile _pickedFilepath;
  bool _isUrl = true;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _name.text = widget.task.name;
      _url.text = widget.task.url;
      _time.text = widget.task.time.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Task Name',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Name is required';
                return null;
              },
              controller: _name,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Time',
              ),
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.isEmpty) return 'time is required';
                if (int.tryParse(val) == null) return 'time should be int';
                return null;
              },
              controller: _time,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: RadioListTile(
                    value: 0,
                    title: Text("AWS Lambda"),
                    groupValue: _isUrl ? 0 : 1,
                    onChanged: (val) {
                      setState(() {
                        _isUrl = val == 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: RadioListTile(
                    value: 1,
                    title: Text("Python File"),
                    groupValue: _isUrl ? 0 : 1,
                    onChanged: (val) {
                      setState(() {
                        _isUrl = val == 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_isUrl)
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Aws Lambda Url',
                ),
                keyboardType: TextInputType.url,
                validator: (val) {
                  if (val.isEmpty) return 'Url is required';
                  return null;
                },
                controller: _url,
              ),
            if (!_isUrl)
              ElevatedButton(
                onPressed: _pickFile,
                child: Text("Pick Python file"),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    widget.task != null ? 'Update Task' : 'Create Task',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (!_isUrl && _pickedFilepath == null) {
      Helper.showToast("File required", false);
      return;
    }

    final task = TaskModel(
      name: _name.text,
      url: _url.text,
      time: int.parse(_time.text),
      id: widget.task != null ? widget.task.id : null,
    );

    if (widget.task != null)
      Provider.of<TaskProvider>(context, listen: false).updateTask(
        task,
        _pickedFilepath,
      );
    else
      Provider.of<TaskProvider>(context, listen: false).createNewTask(
        task,
        _pickedFilepath,
      );

    Navigator.of(context).pop();
  }

  void _pickFile() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        _pickedFilepath = result.files.single;
      }
    } catch (e) {
      Helper.showToast("Something went wrong while picking file", false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _url.dispose();
    _time.dispose();
  }
}
