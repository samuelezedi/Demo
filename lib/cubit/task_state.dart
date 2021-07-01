part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {
  List<Task> tasks;

  TaskInitial(this.tasks);
}

class TaskLoading extends TaskState {
  String loadingText;
  TaskLoading({this.loadingText="Loading"});
}
class TaskMessages extends TaskState  {
  String? message;
  String messageType;
  TaskMessages({this.message,this.messageType='info'});
}

