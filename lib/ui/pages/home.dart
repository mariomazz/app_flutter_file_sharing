import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/services/translator/translator.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final socket = ref.watch(socketProvider);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: backgroundWhiteSmoke,
        title: SelectableText(
          translator.get("home.title"),
          style: primaryTextStyleBold,
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            /* ElevatedButton(
              child: Text(translator.get("home.button.send_file")),
              onPressed: () async {
                final fileSender =
                    File(await getRandomDirectory("filename.txt"));
                await writeDataIntoFile(
                  fileSender,
                  {
                    "body": {
                      "suer": "json",
                      "indentier": {
                        "name": "mario",
                        "surname": "mazzarelli",
                      },
                      "message": "teste",
                      "title": "perrrsaoal",
                    },
                  },
                );
                await socket.sendFile(fileSender, "filename.txt");
              },
            ), */
          ],
        ),
      ),
    );
  }

  Future<String> getRandomDirectory(String filename) async {
    return "${(await getTemporaryDirectory()).path}/$filename";
  }

  Future<File> writeDataIntoFile(File file, Map<String, dynamic> data) async {
    final json = jsonEncode(data);
    return await file.writeAsString(json);
  }
}
