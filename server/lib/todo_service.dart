//import 'dart:math';

import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<TodoList> createTodoList(ServiceCall call, TodoList request) async =>
      todoListsService.createTodoList(request)!;

  @override
  Future<Empty> deleteTodolist(ServiceCall call, TodoList request) async =>
      todoListsService.deleteTodoList(request)!;

  @override
  Future<TodoList> editTodolist(ServiceCall call, TodoList request) async =>
      todoListsService.editTodoList(request)!;

  @override
  Future<TodoLists> getAllTodoLists(ServiceCall call, Empty request) async =>
      TodoLists()..todolists.addAll(todoListsService.getTodoLists()!);

  @override
  Future<TodoList> getTodolist(ServiceCall call, TodoList request) async =>
      todoListsService.getTodoByTitle(request.title)!;

  @override
  Future<TodoList> addTodolistCount(ServiceCall call, TodoList request) async =>
      todoListsService.addTodoListCount(request)!;

  @override
  Future<TodoLists> getAllTodoListLogs(ServiceCall call, Empty request) async =>
      TodoLists()..todolists.addAll(todoListsService.getTodoListLogs()!);

  @override
  Future<TodoList> getTopCostList(ServiceCall call, Empty request) async =>
      todoListsService.getTopCostTodolist()!;

  @override
  Future<TodoLists> getTopThreeList(ServiceCall call, Empty request) async =>
      TodoLists()..todolists.addAll(todoListsService.getTopThreeLists()!);

  @override
  Future<TodoList> getTopTimeList(ServiceCall call, Empty request) async =>
      todoListsService.getTopTimeTodolist()!;
}
