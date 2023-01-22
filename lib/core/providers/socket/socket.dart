import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import '../../utils/logger.dart';
import 'models/file_model.dart' as filemodel;
import 'socket_channels.dart';

class SocketIOServiceProvider with ChangeNotifier {
  String _socketId = "";
  final List<File> _files = [];
  final _socket = io(
    socketLocalUrl,
    OptionBuilder().setTransports(['websocket']).build(),
  );
  SocketIOServiceProvider() {
    _initConnection();
  }

  void _initConnection() {
    _socket.onConnect((_) {
      Logger.log('connect');
    });
    _socket.onDisconnect((_) {
      Logger.log('disconnect');
    });
    _onSocketIdReceive();
  }

  void _onSocketIdReceive() {
    _socket.on(SocketChannels.channelSocketId, (data) {
      if (data != null) {
        Logger.log("socket id $data");
        _socketId = json.decode(data)["socketid"] ?? '';
        _onFileReceive();
      } else {}
    });
  }

  Future<void> sendFile(File file, String filename) async {
    if (_socketId.isNotEmpty) {
      _socket.emit(
        "${SocketChannels.filesSocket}.$_socketId",
        json.encode({
          "file": {
            "filename": filename,
            "fileBase64": base64.encode(await file.readAsBytes()),
          },
          "id": const Uuid().v1(),
        }),
      );
      Logger.log("FILE SENDED");
    } else {
      throw Exception("_socketId not found (isEmpty)");
    }
  }

  void _onFileReceive() {
    if (_socketId.isNotEmpty) {
      _socket.on("client.${SocketChannels.filesSocket}.$_socketId", (data) {
        Logger.log("client file received => $data");
        final file = filemodel.FileModel.fromJson(json.decode(data));
        _files
            .add(File.fromRawPath(base64.decode(file.file?.fileBase64 ?? '')));
        Logger.log("file receive and added to list");
      });
    } else {
      throw Exception("_socketId not found (isEmpty)");
    }
  }
}
