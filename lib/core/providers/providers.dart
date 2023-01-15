import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routing/routing.dart';
import 'opeanai/open_ai.dart';
import 'socket/socket.dart';

final routing = Provider<Routing>((ref) => Routing());
final routingProvider =
    ChangeNotifierProvider<Routing>((ref) => ref.read(routing));
final opeaiService = ChangeNotifierProvider<OpenAiServiceProvider>(
    (ref) => OpenAiServiceProvider(apiKey: "mockApiKey"));
final socketProvider = ChangeNotifierProvider<SocketIOServiceProvider>(
    (ref) => SocketIOServiceProvider());
