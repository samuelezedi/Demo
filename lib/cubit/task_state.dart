part of 'task_cubit.dart';


@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {
  List<Task> tasks;
  int currentIndex;
  TaskInitial(this.tasks,{this.currentIndex=1}){
    currentPage=currentIndex;
  }
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

