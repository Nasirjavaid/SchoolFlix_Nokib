import 'package:flutter/material.dart';

class Destination {
  final String title;
  final IconData icon;
  final Color color;
  const Destination(this.title, this.icon, this.color);
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.redAccent),
  Destination('About', Icons.error_outline,Colors.redAccent),
];
