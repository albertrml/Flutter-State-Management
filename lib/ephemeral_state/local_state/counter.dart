import 'package:flutter/material.dart';

class UIStateCounterScreen extends StatefulWidget {
  final String title;
  const UIStateCounterScreen({super.key, required this.title});

  @override
  State<UIStateCounterScreen> createState() => _UIStateCounterScreenState();
}

class _UIStateCounterScreenState extends State<UIStateCounterScreen> {
  /* 
   * Local UI state.
   * This state belongs only to this widget.
   */
  int counter = 0;

  /*
   * setState() tells Flutter: 
   * "This widget state changed
   * rebuild this widget subtree."
   */
  void increment() => setState(() => counter++);
  void decrement() => setState(() => counter--);
  void reset() => setState(() => counter = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: increment, child: Text('Increment')),

              SizedBox(height: 20),

              ElevatedButton(onPressed: decrement, child: Text('Decrement')),

              SizedBox(height: 20),

              ElevatedButton(onPressed: reset, child: Text('Reset')),
            ],
          ),
        ),
      ),
    );
  }
}
