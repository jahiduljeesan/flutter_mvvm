import 'package:hive/hive.dart';

class HiveBoxes {

  static Box getPostBox() => Hive.box('posts');

}