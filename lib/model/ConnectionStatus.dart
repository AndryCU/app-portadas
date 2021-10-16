import 'package:flutter/material.dart';

class ConnectionStatusView with ChangeNotifier{
  bool _connected=false;

  bool get connected => _connected;

  set connected(bool value) {
    _connected = value;
    print('actualiza $value');
    notifyListeners();
  }
}