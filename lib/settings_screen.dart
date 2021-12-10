import 'package:flutter/material.dart';
import 'duration_formatter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double _currentCountDownValue;

  @override
  void initState() {
    _currentCountDownValue = widget.count.toDouble();
    super.initState();
  }

  String duration() {
    final duration = Duration(
      milliseconds: _currentCountDownValue.toInt() * 3600,
    );
    return duration.toHHMMSS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Slider(
            value: _currentCountDownValue,
            min: 100,
            max: 1000,
            divisions: 90,
            label: _currentCountDownValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentCountDownValue = value;
              });
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(duration()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop<int>(
                      context,
                      _currentCountDownValue.toInt(),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
