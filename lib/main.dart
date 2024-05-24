import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  double _brightness = 1.0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _updateBrightness(double value) {
    setState(() {
      _brightness = value;
    });
  }

  void _resetCounter() async {
    bool? confirmReset = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Reset'),
          content: const Text('Are you sure you want to reset the game?'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmReset == true) {
      setState(() {
        _counter = 0;
        _brightness = 0.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              color: Colors.blueAccent.withOpacity(_brightness),
            ),
            SizedBox(height: 20),
            Text(
              'Number of button presses: $_counter',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text('Counter'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: Text('Reset game'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              value: _brightness,
              min: 0.0,
              max: 1.0,
              onChanged: _updateBrightness,
              label: 'Brightness: ${(_brightness * 100).round()}%',
            ),
          ],
        ),
      ),
    );
  }
}
