import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/cubit/task_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';

class TasksPage extends StatelessWidget {
  TasksPage({@required this.title, this.completedPage = false});

  final String? title;
  final bool completedPage;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addTask(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => TaskCubit(),
                child: TaskPage(),
              )),
    );
    BlocProvider.of<TaskCubit>(context)
        .fetchTasks(FirebaseManager.shared.tasksRef);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchTasks(
        FirebaseManager.shared.tasksRef,
        completedOnly: this.completedPage);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: BlocListener<TaskCubit, TaskState>(
          listener: (context, state) {
            // TODO: implement listener}
            if (state is TaskMessages) {
              _scaffoldKey.currentState?.showSnackBar(SnackBar(
                content: Text("${state.message}"),
                duration: Duration(seconds: 3),
                backgroundColor: state.messageType == "info"
                    ? Colors.black54
                    : state.messageType == "success"
                        ? Colors.green
                        : Colors.red,
              ));
            }
          },
          child: Text(title ?? ""),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addTask(context),
          )
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            List<Task> tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks?.length,
              itemBuilder: (context, index) {
                if (tasks.length == 0) {
                  return Center(
                    child: Text('Add Task'),
                  );
                }
                return _Task(
                  tasks?[index],
                  cPage: completedPage,
                );
              },
            );
          } else if (state is TaskLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}

class _Task extends StatelessWidget {
  _Task(this.task, {this.cPage = false});

  final Task? task;
  final bool cPage;

  void _delete(context, id) {
    //TODO implement delete to firestore
    BlocProvider.of<TaskCubit>(context)
        .deleteTask(FirebaseManager.shared.tasksRef, id);
  }

  void _toggleComplete(context, String? id) {
    //TODO implement toggle complete to firestore
    BlocProvider.of<TaskCubit>(context)
        .markComplete(FirebaseManager.shared.tasksRef, id);
  }

  void _view(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => TaskCubit(),
                child: TaskPage(task: task, edit: true),
              )),
    );
    BlocProvider.of<TaskCubit>(context)
        .fetchTasks(FirebaseManager.shared.tasksRef);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task?.isCompleted ?? false
              ? Icons.check_box
              : Icons.check_box_outline_blank,
        ),
        onPressed: () {
          !this.cPage ? _toggleComplete(context, task?.id) : null;
        },
      ),
      title: Text(task?.title ?? ""),
      subtitle: Text(task?.description ?? ""),
      trailing: this.cPage
          ? IconButton(
              onPressed: null,
              icon: Icon(
                Icons.delete,
                color: Colors.transparent,
              ))
          : IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () {
                _delete(context, task?.id);
              },
            ),
      onTap: () => this.cPage ? null : _view(context),
    );
  }
}
