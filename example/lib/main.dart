import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_files_viewer/system_files_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Package Example Usage",
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final directory = await getApplicationDocumentsDirectory();

            if (context.mounted) {
              SystemFilesViewer.openDirectoryPage(
                context: context,
                directory: directory.parent,
                onFilePageBuilder: (file) {
                  if (file.path.endsWith(".plist")) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text(file.path.split('/').last),
                        ),
                        body: const Center(child: Text("这是一个自定义预览页面")));
                  }
                  return null;
                },
              );
            }
          },
          child: const Text("Enter directory"),
        ),
      ),
    );
  }
}
