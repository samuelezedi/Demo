import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/cubit/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task,this.edit=false});
  final bool edit;
  final Task? task;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task,edit:edit),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task,{this.edit=false});

  final bool edit;

  final Task? task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  Task? task;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task?.title);
      _descriptionController = TextEditingController(text: task?.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    //TODO implement save to firestore
    Navigator.of(context).pop();
    if(widget.edit){
      BlocProvider.of<TaskCubit>(context).addTask(FirebaseManager.shared.tasksRef, _titleController?.text, _descriptionController?.text,id: task?.id);
    }else{
      BlocProvider.of<TaskCubit>(context).addTask(FirebaseManager.shared.tasksRef, _titleController?.text, _descriptionController?.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TaskCubit>(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed ?'),
                CupertinoSwitch(
                  value: task?.isCompleted??false,
                  onChanged: (_) {
                    setState(() {
                      task?.toggleComplete();
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => _save(context),
              child: Container(
                width: double.infinity,
                child: Center(child: Text(task?.isNew??false ? 'Create' : 'Update')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
