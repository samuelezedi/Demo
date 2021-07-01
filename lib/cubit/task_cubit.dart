import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial([]));

  void fetchTasks(CollectionReference taskRef,
      {bool fromSecond = false, bool completedOnly = false}) async {
    emit(TaskLoading());
    QuerySnapshot data = await taskRef.get();
    if (data.docs.length > 0) {

      taskLoaded(data,completedOnly:completedOnly);
    }
  }

  void addTask(CollectionReference taskRef, String? title, String? description,
      {String? id = ""}) async {
    emit(TaskMessages(message: id==""?"Adding Task":"Editing task"));
    final task = Task()
      ..title = title
      ..description = description;
    id == ""
        ? taskRef.add(task.toJson())
        : taskRef.doc(id).update(task.toJson());
  }

  void deleteTask(CollectionReference taskRef, String? id) {
    taskRef.doc(id).delete();
    emit(TaskMessages(message: "Task Deleted",messageType: "danger"));
    fetchTasks(taskRef);
  }

  void markComplete(CollectionReference taskRef, String? id,) {
    taskRef.doc(id).update({'completed_at' :  Timestamp.now()});
    emit(TaskMessages(message: "Task completed",messageType: "success"));
    fetchTasks(taskRef);
  }

  taskLoaded(QuerySnapshot data,{completedOnly}) {
    List<Task> values = [];
    if(completedOnly){
      values = data.docs.map((e) {
          Task sfd = Task()
            ..id = e.id
            ..description = e.get('description')
            ..title = e.get('title')
            ..completedAt = e.get('completed_at');
          return sfd;
      }).where((e) => (e.completedAt!=null)).toList();

    } else  {

      values = data.docs.map((e) {
        Task sfd = Task()
          ..id = e.id
          ..description = e.get('description')
          ..title = e.get('title')
          ..completedAt = e.get('completed_at');
        return sfd;

      }).toList();
    }
    emit(TaskInitial(values));
  }

  void onTabTapped(int index) {
    var currentState = state;
    if (currentState is TaskInitial) {
      emit(TaskInitial(currentState.tasks));
    }
  }
}
