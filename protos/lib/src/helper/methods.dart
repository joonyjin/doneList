// helper class for assistance
import 'package:protos/protos.dart';

class HelperMethods {
  TodoList getTodoListFromMap(Map todolist) {
    var idTag = 1;
    var titleTag = 2;
    var countTag = 3;
    var costTag = 4;
    var timeTag = 5;
    int id = todolist['id'];
    String title = todolist['title'];
    int count = todolist['count'];
    int cost = todolist['cost'];
    int time = todolist['time'];
    return TodoList.fromJson(
        '{"$idTag": $id, "$titleTag": "$title", "$countTag": $count, "$costTag": $cost, "$timeTag": $time}');
  }

  TodoList getTodoLogFromMap(Map todolist) {
    var idTag = 1;
    var titleTag = 2;
    var countTag = 3;
    var costTag = 4;
    var timeTag = 5;
    var actionTag = 6;
    int id = todolist['id'];
    String title = todolist['title'];
    int count = todolist['count'];
    int cost = todolist['cost'];
    int time = todolist['time'];
    String action = todolist['action'];
    return TodoList.fromJson(
        '{"$idTag": $id, "$titleTag": "$title", "$countTag": $count, "$costTag": $cost, "$timeTag": $time, "$actionTag": "$action"}');
  }

  Map<String, dynamic> getTodoLogMapFromList(TodoList todoList, String what) {
    int id = todoList.id;
    String title = todoList.title;
    String action = what;
    int count = todoList.count;
    int cost = todoList.cost;
    int time = todoList.time;
    return {
      'action': action,
      'id': id,
      'title': title,
      'count': count,
      'cost': cost,
      'time': time,
    };
  }
}

final helper = HelperMethods();
