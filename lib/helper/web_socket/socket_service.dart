import 'dart:async';
import 'dart:convert';
import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_key.dart';
import 'package:fix_flex/helper/secure_storage/secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = StreamController<Map<String,dynamic>>.broadcast();
  final _socketChatRoom = StreamController<Map<String,dynamic>>.broadcast();
  final _socketNewOffer = StreamController<Map<String,dynamic>>.broadcast();

  void Function(Map<String, dynamic> event) get addResponse => _socketResponse.sink.add;
  void Function(Map<String, dynamic> event) get addChatRoom => _socketChatRoom.sink.add;
  void Function(Map<String, dynamic> event) get addNewOffer => _socketNewOffer.sink.add;

  Stream<Map<String, dynamic>> get getResponse => _socketResponse.stream;
  Stream<Map<String, dynamic>> get getChatRoom => _socketChatRoom.stream;
  Stream<Map<String, dynamic>> get getNewOffer => _socketChatRoom.stream;

  void dispose() {
    _socketResponse.close();
    _socketChatRoom.close();
    _socketNewOffer.close();
  }
}

StreamSocket streamSocket = StreamSocket();
late IO.Socket socket;

Future<void> connectAndListen({chatsId}) async {
  final token = await SecureStorage.getData(key: SecureKey.token);
  socket = IO.io(
    EndPoints.chatWebSocket,
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .setExtraHeaders({'Authorization': 'Bearer $token'})
        .enableAutoConnect()
        .build(),
  );

  socket.onConnect((_) {
    print('connect');
    socket.emit('joinMyRoom');
    for (int i = 0; i < chatsId.length; i++) {
      socket.emit('joinChatRoom', chatsId[i]);
      print('joinChatRoom ${chatsId[i]}');
    }
  });

  socket.on('message', (data) {
    var decodedData = json.decode(data);
    print('New message received: $decodedData');
    streamSocket.addResponse(decodedData);
  });

  socket.on('newChatRoom', (data) {
    print('newChatRoom $data');
    var decodedData = json.decode(data);
    socket.emit('joinChatRoom', decodedData['_id']);
    streamSocket.addChatRoom(decodedData);
    print('joinChatRoom ${decodedData['_id']}');
  });

  socket.on('newOffer', (data) {
    streamSocket.addNewOffer(data);
    print('newOffer $data');
  });

  socket.onDisconnect((_) => print('disconnect'));
}
