import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketManager {
  final String serverUrl;
  final WebSocketChannel _channel;
  final StreamController<dynamic> _dataStreamController = StreamController<dynamic>.broadcast();

  bool _isReconnecting = false;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;
  final Duration _initialReconnectDelay = const Duration(seconds: 2);

  WebSocketManager(this.serverUrl) : _channel = IOWebSocketChannel.connect(serverUrl) {
    _channel.stream.listen(
          (data) {
        _dataStreamController.add(data);
      },
      onDone: () {
        _handleWebSocketClosed();
      },
      onError: (error) {
        _handleWebSocketError(error);
      },
    );
  }

  Stream<dynamic> get dataStream => _dataStreamController.stream;

  void _reconnect() {
    if (_isReconnecting || _reconnectAttempts >= _maxReconnectAttempts) {
      _dataStreamController.addError('Max reconnection attempts reached');
      _dataStreamController.close();
      return;
    }

    _isReconnecting = true;
    _reconnectAttempts++;
    final Duration delay = _initialReconnectDelay * _reconnectAttempts;
    print('Reconnecting to WebSocket in ${delay.inSeconds} seconds...');

    Future.delayed(delay, () {
      _isReconnecting = false;
      WebSocketManager(serverUrl); // Reconnect
    });
  }

  void _handleWebSocketClosed() {
    print('WebSocket connection closed');
    _reconnect();
  }

  void _handleWebSocketError(dynamic error) {
    print('WebSocket Error: $error');
    _reconnect();
  }

  void sendData(dynamic data) {
    _channel.sink.add(data);
    // if (!_channel.sink.closed) {
    //   _channel.sink.add(data);
    // } else {
    //   _dataStreamController.addError('WebSocket connection is closed');
    // }
  }

  void close() {
    _dataStreamController.close();
    _channel.sink.close();
  }
}
