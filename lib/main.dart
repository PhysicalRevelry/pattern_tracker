import 'package:flutter/material.dart';
// import 'package:pattern_tracker/screens/first.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pattern_tracker/screens/pattern_test.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      theme: ThemeData.dark(),
      // home: ScraperApp(),
      home: const PatternScraper(),
    ),
  ));
}


