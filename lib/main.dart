import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example/platform_channel/getNativeData');

  static const platform_library = MethodChannel('com.example.datetime_example/dateTime');
  String _dateTime = 'Unknown';

  String _response = 'Waiting for response...';

  Future<void> _getCurrentDateTime() async {
    try {
      final String result = await platform_library.invokeMethod('getCurrentDateTime');
      setState(() {
        _dateTime = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _dateTime = "Failed to get dateTime: '${e.message}'.";
      });
    }
  }

  Future<void> _getNativeMessage() async {
    String response;
    try {
      final String result = await platform.invokeMethod('getNativeMessage');
      response = 'Message: $result';
    } on PlatformException catch (e) {
      response = "Failed to get native response: '${e.message}'.";
    }

    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _response,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getNativeMessage,
              child: const Text('Get Native Message'),
            ),
            const SizedBox(height: 20),
            Text(
              _dateTime,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentDateTime,
              child: const Text('Get Native DateTime'),
            ),
          ],
        ),
      ),
    );
  }
}
