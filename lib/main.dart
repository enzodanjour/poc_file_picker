import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:open_filex/open_filex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FilePickerResult? result;
  void _incrementCounter() async {
    result = await FilePicker.platform.pickFiles();
    setState(() {});
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes == 0) {
      return '0 Bytes';
    }
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  openFile(String path) {
    OpenFilex.open(result?.files.single.path ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            TextButton(
              child: Text(
                '${result?.files.single.name}',
                style: Theme.of(context).textTheme.headline4,
              ),
              onPressed: () {
                openFile(result?.files.single.path ?? '');
              },
            ),
            Text(
              '${getFileSizeString(bytes: result?.files.single.size ?? 0)}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
