import 'dart:async';

import 'package:flutter/material.dart';
import 'settings_screen.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _count = 1000;
  bool started = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push<int>(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    count: _count,
                  ),
                ),
              );
              if (result != null) {
                setState(() {
                  _count = result;
                });
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _count.toString(),
              style: const TextStyle(
                fontSize: 128,
                fontWeight: FontWeight.w100,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!started) {
                  Timer.periodic(const Duration(milliseconds: 3600),
                      (timer) async {
                    if (started) {
                      setState(() {
                        --_count;
                        if (_count == 0) {
                          timer.cancel();
                          setState(() {
                            _count = 1000;
                            started = false;
                          });
                        }
                      });
                    } else {
                      timer.cancel();
                    }
                  });
                  setState(() {
                    started = true;
                  });
                } else {
                  setState(() {
                    _count = 1000;
                    started = false;
                  });
                }
              },
              child: Text(started ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
