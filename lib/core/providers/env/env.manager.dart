import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'models/base_config.dart';

final EnvManager env = EnvManager.getInstance();

class EnvManager implements BaseConfig {
  static EnvManager getInstance() => inst_;
  static late final EnvManager inst_;
  static Future<EnvManager> initAndFetch(
      FirebaseRemoteConfig remoteConfig) async {
    final instance = EnvManager(remoteConfig);
    instance._configurations = await instance.fetchFireBaseConfiguration();
    instance._test();
    inst_ = instance;
    return instance;
  }

  final FirebaseRemoteConfig remoteConfig;

  EnvManager(this.remoteConfig);

  Map<String, dynamic> _configurations = {};

  dynamic _getObj(Map<String, dynamic> configurations, String key) {
    return configurations[key];
  }

  Future<Map<String, dynamic>> fetchFireBaseConfiguration() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 3),
      minimumFetchInterval: const Duration(hours: 0),
    ));

    await remoteConfig.setDefaults(await _fetchJsonProd());
    try {
      await remoteConfig.fetchAndActivate();
      // ignore: empty_catches
    } catch (e) {}

    const defaultEnv = kReleaseMode ? 'prod' : 'dev';

    final env =
        const String.fromEnvironment("ENVIRONMENT", defaultValue: defaultEnv)
            .toLowerCase();

    final configurations =
        json.decode(remoteConfig.getValue('${env}_appconfig').asString());

    return configurations;
  }

  Future<Map<String, dynamic>> _fetchJsonProd() async {
    return (await json
                .decode(await rootBundle.loadString('assets/envs/prod.json'))
            as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, json.encode(value)));
  }

  void _test() {
    final List conf = [
      envName,
      appId,
    ];

    for (var element in conf) {
      if (element.isEmpty) {
        throw Exception("check configurations => $conf");
      }
    }
  }

  @override
  String get envName => _getObj(_configurations, "envName");

  @override
  String get appId => _getObj(_configurations, "appId");
}
