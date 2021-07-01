import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/user.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/weather.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/home_feeds_manager.dart';
import 'package:morphosis_flutter_demo/services/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchTextField = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
    initializeHomeData();
  }

  addUser() {
    initializeHomeData();
  }

  deleteUser(index) {
    Boxes.getUsers().deleteAt(index);
  }

  initializeHomeData() async {
    Map data = await HomeFeedsRepo.getUsers();

    final user = User()
      ..name = "${data['name']}"
      ..username = "${data['username']}"
      ..email = "${data['email']}"
      ..id = "${data['id']}";

    Boxes.getUsers().add(user);
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    // Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(onPressed: addUser, icon: Icon(Icons.refresh))],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoSearchTextField(
              controller: _searchTextField,
              placeholder: "Search",
              onChanged: (input) {
                if (input.trim() == "") {
                  setState(() {
                    searching = false;
                  });
                } else {
                  setState(() {
                    searching = true;
                  });
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
            ValueListenableBuilder<Box<User>>(
              valueListenable: Boxes.getUsers().listenable(),
              builder: (context, box, _) {
                final userView = box.values
                    .where((element) {
                      if (searching) {
                        print(_searchTextField.text);
                        return element.username
                                .toString()
                                .toLowerCase()
                                .contains(
                                    _searchTextField.text.toLowerCase()) ||
                            element.name
                                .toString()
                                .toLowerCase()
                                .contains(_searchTextField.text.toLowerCase());
                      } else {
                        return true;
                      }
                    })
                    .toList()
                    .cast<User>();
                return Expanded(
                  child: ListView.builder(
                      itemCount: userView.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(userView[index].id.toString()),
                          title: Text(userView[index].name.toString()),
                          subtitle: Text(userView[index].username.toString()),
                          trailing: IconButton(
                            onPressed: () {
                              deleteUser(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
