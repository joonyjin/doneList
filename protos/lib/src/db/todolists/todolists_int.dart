import 'package:protos/protos.dart';

var todoList = TodoList();
var empty = Empty();
var ltodoList = <TodoList>[];

abstract class ITodoListsService {
  factory ITodoListsService() => TodoListsService();
  TodoList? getTodoByTitle(String title) {
    return todoList;
  }

  TodoList? getTodoById(int id) {
    return todoList;
  }

  TodoList? createTodoList(TodoList todoList) {
    return todoList;
  }

  TodoList? editTodoList(TodoList todoList) {
    return todoList;
  }

  Empty? deleteTodoList(TodoList todoList) {
    return empty;
  }

  List<TodoList>? getTodoLists() {
    return ltodoList;
  }

  List<TodoList>? getTodoListLogs() {
    return ltodoList;
  }

  List<TodoList>? getTopThreeLists() {
    return ltodoList;
  }

  TodoList? getTopTimeTodolist() {
    return todoList;
  }

  TodoList? getTopCostTodolist() {
    return todoList;
  }

  TodoList? addTodoListCount(TodoList todoList) {
    return todoList;
  }
}

final todoListsService = ITodoListsService();
