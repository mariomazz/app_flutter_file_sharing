import 'models/base_config.dart';

final EnvManager env = EnvManager.instance;

class EnvManager implements BaseConfig {
  Map<String, dynamic> _configurations = {};
  Map<String, dynamic> get allConfigs => _configurations;
  static late final EnvManager _instance;
  static EnvManager get instance => _instance;
  static Future<EnvManager> initAndFetchEnv() async {
    _instance = EnvManager();
    _instance._configurations = await _instance._fetchFireBaseConfiguration();
    _instance._test();
    return _instance;
  }

  dynamic _getObj(Map<String, dynamic> configurations, String key) {
    return configurations[key];
  }

  Future<Map<String, dynamic>> _fetchFireBaseConfiguration() async {
    _getObj({}, "");
    return {};
  }

  void _test() {
    final List<dynamic> conf = [];

    for (var element in conf) {
      if (element.isEmpty) {
        throw Exception("check configurations => $conf");
      }
    }
  }
}
