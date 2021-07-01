import 'package:hive/hive.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/user.dart';

class Boxes {
  static Box<User> getUsers() => Hive.box<User>('user');
}

extension ExtendedString on String {
  bool containsLowerCases(String value) {
    return this.toLowerCase().contains(value);
  }
}