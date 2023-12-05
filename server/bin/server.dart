//grpc server
import 'dart:io';
import 'package:protos/protos.dart';
import 'package:server/todo_service.dart';

Future<void> main(List<String> arguments) async {
  final server = Server.create(
      services: [
        TodoService()
      ],
      //interceptors are called before grpc calls the service => authentication & login useful
      //if interceptors => error => not authenticated
      interceptors: [],
      //keep track of methods that is used to compress and decompress data
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]));

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  await server.serve(
    port: port,
  );

  print('Server listening on port ${server.port} ...');
}
