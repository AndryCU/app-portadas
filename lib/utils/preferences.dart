import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  bool get start {
    return _prefs.getBool('start') ?? false;
  }

  set start(bool value) {
    _prefs.setBool('start', value);
  }

  bool get hasDataLoading {
    return _prefs.getBool('hasDataLoading') ?? false;
  }

  set hasDataLoading(bool value) {
    _prefs.setBool('hasDataLoading', value);
  }
  bool get hasDataLoading2 {
    return _prefs.getBool('hasDataLoading2') ?? false;
  }

  set hasDataLoading2(bool value) {
    _prefs.setBool('hasDataLoading2', value);
  }
}
