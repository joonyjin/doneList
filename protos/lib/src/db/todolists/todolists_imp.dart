import 'package:protos/protos.dart';

//{'id': 1, 'title': '유투브 보기', 'count': 1, 'cost': 0, 'time': 60}
class TodoListsService implements ITodoListsService {
  @override
  TodoList? createTodoList(TodoList todoList) {
    todolists.add({'id': todoList.id, 'title': todoList.title, 'count': 1, 'cost': todoList.cost, 'time': todoList.time});
    var map = helper.getTodoLogMapFromList(todoList, 'Init');
    todolistsLog.add(map);
    print("CreateTodoList : ${todoList..toString()}");
    return todoList;
  }

  @override
  Empty? deleteTodoList(TodoList todoList) {
    todolists.removeWhere((element) => element['id'] == todoList.id);
    var map = helper.getTodoLogMapFromList(todoList, 'Delete');
    todolistsLog.add(map);
    print("DeleteTodoList : ${todoList.toString()}");
    return Empty();
  }

  @override
  TodoList? editTodoList(TodoList todoList) {
    try {
      var todoIndex = todolists.indexWhere((element) => element['id'] == todoList.id);
      todolists[todoIndex]['title'] = todoList.title;
      print("editTodoList : ${todoList.toString()}");
    } catch (e) {
      print('ERROR:: $e');
    }
    return todoList;
  }

  @override
  TodoList? addTodoListCount(TodoList todoList) {
    try {
      var map = helper.getTodoLogMapFromList(todoList, 'Update');
      todolistsLog.add(map);
      var todoIndex = todolists.indexWhere((element) => element['id'] == todoList.id);
      todolists[todoIndex]['count'] += todoList.count;
      todolists[todoIndex]['cost'] += todoList.cost;
      todolists[todoIndex]['time'] += todoList.time;
      print("addTodoListCount: ${todoList.toString()}");
    } catch (e) {
      print('ERROR:: $e');
    }
    return todoList;
  }

  @override
  TodoList? getTodoById(int id) {
    var todoList = TodoList();
    var result = todolists.where((element) => element['id'] == id).toList();
    if (result.isNotEmpty) {
      todoList = helper.getTodoListFromMap(result.first);
    }
    print("getTodoById: ${todoList.toString()}");
    return todoList;
  }

  @override
  TodoList? getTodoByTitle(String title) {
    var todoList = TodoList();
    var result = todolists.where((element) => element['title'] == title).toList();
    if (result.isNotEmpty) {
      //category's name is unique => only wants the first element (don't get it yet);
      todoList = helper.getTodoListFromMap(result.first);
    }
    print("getTodoByTitle: ${todoList.toString()}");
    //if category is null -> its element will have default values ( id : 0, name : " ");
    return todoList;
  }

  @override
  List<TodoList>? getTodoLists() {
    return todolists.map((todolist) {
      print("Fetching all TodoLists...");
      return helper.getTodoListFromMap(todolist);
    }).toList();
  }

  @override
  List<TodoList>? getTodoListLogs() {
    return todolistsLog.map((todolist) {
      print("Fetching TodoListsLogs...");
      return helper.getTodoLogFromMap(todolist);
    }).toList();
  }

  @override
  TodoList? getTopCostTodolist() {
    var topCost = <String, dynamic>{};
    for (var map in todolists) {
      if (map['id'] == 1) {
        topCost = map;
      } else {
        if (map['cost'] > topCost['cost']) {
          topCost = map;
        }
      }
    }
    print("getTopCostTodolist : ${topCost.toString()}");
    return helper.getTodoListFromMap(topCost);
  }

  @override
  List<TodoList>? getTopThreeLists() {
    todolists.sort((a, b) => b['count'].compareTo(a['count']));
    final top3 = todolists.take(3);
    var lists = <TodoList>[];
    for (var item in top3) {
      lists.add(helper.getTodoListFromMap(item));
    }
    print("getTopThreeLists : ${lists.toString()}");
    return lists;
  }

  @override
  TodoList? getTopTimeTodolist() {
    var topTime = <String, dynamic>{};
    for (var map in todolists) {
      if (map['id'] == 1) {
        topTime = map;
      } else {
        if (map['time'] > topTime['time']) {
          topTime = map;
        }
      }
    }
    print("getTopTimeTodolist : ${topTime.toString()}");
    return helper.getTodoListFromMap(topTime);
  }
}
