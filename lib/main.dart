import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/env/env.manager.dart';
import 'core/services/translator/translator.dart';
import 'firebase_options.dart';
import 'ui/widgets/app.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  await Translator.loadLanguage();
  await EnvManager.initAndFetch(FirebaseRemoteConfig.instance);
  runApp(const ProviderScope(child: FileSharing()));
}

class FileSharing extends StatelessWidget {
  const FileSharing({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp();
  }
}
