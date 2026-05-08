import 'package:flutter/material.dart';

class Problem {
  final String name;
  final double time;
  final Color color;
  const Problem(this.name, this.time, this.color);

  String getTitle() => "$name\n(${(time * 100).toStringAsFixed(2)}%)";
}

List<Problem> createData(double stateMgmtTime) => <Problem>[
  Problem('State Management', stateMgmtTime, Colors.blue),
  Problem('UX', (1 - stateMgmtTime) * (1 / 6), Colors.green),
  Problem('UI', (1 - stateMgmtTime) * (2 / 6), Colors.orange),
  Problem('Backend', (1 - stateMgmtTime) * (3 / 6), Colors.grey),
];
