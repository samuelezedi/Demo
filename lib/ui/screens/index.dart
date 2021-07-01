import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/cubit/task_cubit.dart';
import 'package:morphosis_flutter_demo/main.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    currentPage = index;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      HomePage(),
      BlocProvider(
        create: (context) => TaskCubit(),
        child: TasksPage(
          title: 'All Tasks',
        ),
      ),
      BlocProvider(
        create: (context) => TaskCubit(),
        child: TasksPage(
          title: 'Completed Tasks',
          completedPage: true,
        ),
      )
    ];

    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
