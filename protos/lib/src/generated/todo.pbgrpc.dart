//
//  Generated code. Do not modify.
//  source: todo.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'todo.pb.dart' as $0;

export 'todo.pb.dart';

@$pb.GrpcServiceName('TodoService')
class TodoServiceClient extends $grpc.Client {
  static final _$createTodoList = $grpc.ClientMethod<$0.TodoList, $0.TodoList>(
      '/TodoService/createTodoList',
      ($0.TodoList value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$getAllTodoLists = $grpc.ClientMethod<$0.Empty, $0.TodoLists>(
      '/TodoService/getAllTodoLists',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoLists.fromBuffer(value));
  static final _$getAllTodoListLogs = $grpc.ClientMethod<$0.Empty, $0.TodoLists>(
      '/TodoService/getAllTodoListLogs',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoLists.fromBuffer(value));
  static final _$getTopThreeList = $grpc.ClientMethod<$0.Empty, $0.TodoLists>(
      '/TodoService/getTopThreeList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoLists.fromBuffer(value));
  static final _$getTopCostList = $grpc.ClientMethod<$0.Empty, $0.TodoList>(
      '/TodoService/getTopCostList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$getTopTimeList = $grpc.ClientMethod<$0.Empty, $0.TodoList>(
      '/TodoService/getTopTimeList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$getTodolist = $grpc.ClientMethod<$0.TodoList, $0.TodoList>(
      '/TodoService/getTodolist',
      ($0.TodoList value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$editTodolist = $grpc.ClientMethod<$0.TodoList, $0.TodoList>(
      '/TodoService/editTodolist',
      ($0.TodoList value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$deleteTodolist = $grpc.ClientMethod<$0.TodoList, $0.Empty>(
      '/TodoService/deleteTodolist',
      ($0.TodoList value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$addTodolistCount = $grpc.ClientMethod<$0.TodoList, $0.TodoList>(
      '/TodoService/addTodolistCount',
      ($0.TodoList value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));

  TodoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.TodoList> createTodoList($0.TodoList request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTodoList, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoLists> getAllTodoLists($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllTodoLists, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoLists> getAllTodoListLogs($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllTodoListLogs, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoLists> getTopThreeList($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopThreeList, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoList> getTopCostList($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopCostList, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoList> getTopTimeList($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopTimeList, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoList> getTodolist($0.TodoList request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTodolist, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoList> editTodolist($0.TodoList request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$editTodolist, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteTodolist($0.TodoList request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTodolist, request, options: options);
  }

  $grpc.ResponseFuture<$0.TodoList> addTodolistCount($0.TodoList request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTodolistCount, request, options: options);
  }
}

@$pb.GrpcServiceName('TodoService')
abstract class TodoServiceBase extends $grpc.Service {
  $core.String get $name => 'TodoService';

  TodoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TodoList, $0.TodoList>(
        'createTodoList',
        createTodoList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.TodoLists>(
        'getAllTodoLists',
        getAllTodoLists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.TodoLists value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.TodoLists>(
        'getAllTodoListLogs',
        getAllTodoListLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.TodoLists value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.TodoLists>(
        'getTopThreeList',
        getTopThreeList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.TodoLists value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.TodoList>(
        'getTopCostList',
        getTopCostList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.TodoList>(
        'getTopTimeList',
        getTopTimeList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoList, $0.TodoList>(
        'getTodolist',
        getTodolist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoList, $0.TodoList>(
        'editTodolist',
        editTodolist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoList, $0.Empty>(
        'deleteTodolist',
        deleteTodolist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoList, $0.TodoList>(
        'addTodolistCount',
        addTodolistCount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
  }

  $async.Future<$0.TodoList> createTodoList_Pre($grpc.ServiceCall call, $async.Future<$0.TodoList> request) async {
    return createTodoList(call, await request);
  }

  $async.Future<$0.TodoLists> getAllTodoLists_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAllTodoLists(call, await request);
  }

  $async.Future<$0.TodoLists> getAllTodoListLogs_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAllTodoListLogs(call, await request);
  }

  $async.Future<$0.TodoLists> getTopThreeList_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getTopThreeList(call, await request);
  }

  $async.Future<$0.TodoList> getTopCostList_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getTopCostList(call, await request);
  }

  $async.Future<$0.TodoList> getTopTimeList_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getTopTimeList(call, await request);
  }

  $async.Future<$0.TodoList> getTodolist_Pre($grpc.ServiceCall call, $async.Future<$0.TodoList> request) async {
    return getTodolist(call, await request);
  }

  $async.Future<$0.TodoList> editTodolist_Pre($grpc.ServiceCall call, $async.Future<$0.TodoList> request) async {
    return editTodolist(call, await request);
  }

  $async.Future<$0.Empty> deleteTodolist_Pre($grpc.ServiceCall call, $async.Future<$0.TodoList> request) async {
    return deleteTodolist(call, await request);
  }

  $async.Future<$0.TodoList> addTodolistCount_Pre($grpc.ServiceCall call, $async.Future<$0.TodoList> request) async {
    return addTodolistCount(call, await request);
  }

  $async.Future<$0.TodoList> createTodoList($grpc.ServiceCall call, $0.TodoList request);
  $async.Future<$0.TodoLists> getAllTodoLists($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.TodoLists> getAllTodoListLogs($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.TodoLists> getTopThreeList($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.TodoList> getTopCostList($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.TodoList> getTopTimeList($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.TodoList> getTodolist($grpc.ServiceCall call, $0.TodoList request);
  $async.Future<$0.TodoList> editTodolist($grpc.ServiceCall call, $0.TodoList request);
  $async.Future<$0.Empty> deleteTodolist($grpc.ServiceCall call, $0.TodoList request);
  $async.Future<$0.TodoList> addTodolistCount($grpc.ServiceCall call, $0.TodoList request);
}
