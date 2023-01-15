import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/env/env.manager.dart';
import 'core/services/translator/translator.dart';
import 'ui/widgets/app.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Translator.loadLanguage();
  await EnvManager.initAndFetchEnv();
  runApp(const ProviderScope(child: FileSharing()));
}

class FileSharing extends StatelessWidget {
  const FileSharing({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp();
  }
}
