//todo fetch list of task
//todo check if task are added to firebase
//todo check if I can delete task
//todo check if I can update task

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

main()  {

  Future fetchTasks(
      {bool fromSecond = false, bool completedOnly = false}) async {

    CollectionReference taskRef = FirebaseFirestore.instance.collection('tasks');
    QuerySnapshot data = await taskRef.get();
    return data;
  }

  test("Should be able to get list of Task",()async{
    //Arrange
    List data = [];
    QuerySnapshot task = await fetchTasks();
    expect(data.runtimeType, task.docs.runtimeType);
  });

  test("Should be able to add task to firebase",(){

  });

  test("Should be able to delete task from firebase",(){

  });

  test("Should be able to update task from firebase",(){

  });
}