import 'dart:io';
import 'dart:math';
import 'package:protos/protos.dart';

class Client {
  ClientChannel? _channel;
  //stub will know all the functions that is defined on server => a key to talk to server
  TodoServiceClient? _stub;
  dynamic _response;
  bool executionInProgress = true;

  Future<void> main() async {
    _channel = ClientChannel('localhost',
        port: 8080,
        // using http instead of https options
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    _stub = TodoServiceClient(_channel!,
        //if 30seconds nothing from server => terminate request
        options: CallOptions(timeout: Duration(seconds: 30)));

//stop execution on console app
    while (executionInProgress) {
      try {
        print('     ---- Welcome! ----');
        print('--- What do you want to do ? ---');
        print(' 1: View all TodoLists');
        print(' 2: Add new TodoList');
        print(' 3: Countup TodoList');
        print(' 4: Get TodoList');
        print(' 5: Delete TodoList');
        print(' 6: View all Logs');
        print(' 7: Get Top Costful Todo');
        print(' 8: Get Top TimeWaste Todo');
        print(' 9: Get Top 3 Activities you\'ve done');

        var option = int.parse(stdin.readLineSync()!);

        switch (option) {
          case 1:
            _response = await _stub!.getAllTodoLists(Empty());
            print(' --- TodoLists --- ');
            _response.todolists.forEach((todolist) {
              print(
                  '-> : ${todolist.title} (id: ${todolist.id} | count: ${todolist.count} | cost: ${todolist.cost} | time: ${todolist.time}) ');
            });
            break;
          case 2:
            print('Enter Title');
            var title = stdin.readLineSync()!;
            var todoList = await _findTodoListByTitle(title);
            if (todoList.id != 0) {
              print(
                  ' product already exists: name ${todoList.title} | id: ${todoList.id} ');
            } else {
              print('Enter how much it costs');
              var cost = int.parse(stdin.readLineSync()!);
              print('Enter how much time it took');
              var time = int.parse(stdin.readLineSync()!);
              todoList = TodoList()
                ..title = title
                ..id = _randomId()
                ..count = 1
                ..cost = cost
                ..time = time;
              _response = await _stub!.createTodoList(todoList);
              print(
                  ' todo created | name ${_response.title} | id ${_response.id}');
            }
            break;
          case 3:
            print('Enter todo title');
            var title = stdin.readLineSync()!;
            var todoList = await _findTodoListByTitle(title);
            if (todoList.id != 0) {
              print('Enter costs');
              var cost = int.parse(stdin.readLineSync()!);
              print('Enter time');
              var time = int.parse(stdin.readLineSync()!);
              _response = await _stub!.addTodolistCount(TodoList(
                  id: todoList.id,
                  title: todoList.title,
                  count: 1,
                  cost: cost,
                  time: time));
              if (_response.title == title) {
                print(
                    ' todoList updated | name ${_response.title} | id ${_response.id}');
              } else {
                print(' todoList update failed');
              }
            } else {
              print(' product $title not found, try creating it!');
            }
            break;
          case 4:
            print('Enter todolist title');
            var title = stdin.readLineSync()!;
            var todoList = await _findTodoListByTitle(title);
            if (todoList.id != 0) {
              print(' todo found | name ${todoList.title} | id ${todoList.id}');
            } else {
              print(' todo not found | no todo matches the name $title');
            }
            break;
          case 5:
            print('Enter todo title');
            var title = stdin.readLineSync()!;
            var todoList = await _findTodoListByTitle(title);
            if (todoList.id != 0) {
              await _stub!.deleteTodolist(todoList);
              print(' $title deleted');
            } else {
              print(' product $title does not exist');
            }
            break;
          case 6:
            _response = await _stub!.getAllTodoListLogs(Empty());
            print(' --- TodoLists Logs --- ');
            _response.todolists.forEach((todolist) {
              print(
                  '-> : ${todolist.action} ${todolist.title} (id: ${todolist.id} | count: ${todolist.count} | cost: ${todolist.cost} | time: ${todolist.time}) ');
            });
            break;
          case 7:
            _response = await _stub!.getTopCostList(Empty());
            print(' --- Top 1 Money Spent on --- ');
            print('-> : ${_response.title} with ${_response.cost} ');
            break;
          case 8:
            _response = await _stub!.getTopTimeList(Empty());
            print(' --- Top 1 Time Spent on --- ');
            print('-> : ${_response.title} with ${_response.time} minutes ');
            break;
          case 9:
            _response = await _stub!.getTopThreeList(Empty());
            print(' --- Top 3 Activities are --- ');
            _response.todolists.forEach((todolist) {
              print('-> : ${todolist.title} with ${todolist.count} times');
            });
            break;
          default:
            print('invalid option');
        }
      } catch (e) {
        print(e);
      }
      print('Do you wish to exit? (Y/n)');
      var result = stdin.readLineSync() ?? 'y';
      executionInProgress = result.toLowerCase() != 'y';
    }
    await _channel!.shutdown();
  }

  Future<TodoList> _findTodoListByTitle(String title) async {
    var todoList = TodoList()..title = title;
    todoList = await _stub!.getTodolist(todoList);
    return todoList;
  }

  int _randomId() => Random(1000).nextInt(9999);
}

void main() {
  var client = Client();
  client.main();
}
