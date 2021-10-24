import 'package:flutter/material.dart';

class ConnectionStatusView with ChangeNotifier{
  bool _connected=false;
  bool _hasDataLoading=false;
  bool get connected => _connected;

  set connected(bool value) {
    _connected = value;
    print('cambia valor de la conexion $value');
    notifyListeners();
  }

  bool get hasDataLoading => _hasDataLoading;

  set hasDataLoading(bool value) {
    _hasDataLoading = value;
    print('cambia valor del hasDataLoading $value');
    notifyListeners();
  }
}