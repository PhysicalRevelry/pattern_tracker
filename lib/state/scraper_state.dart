import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class Step {
  final int order;
  final String instruction;

  Step({required this.order, required this.instruction});
}

class Pattern {
  final String url;
  final String name;
  List<Step> steps;

  Pattern({required this.url, required this.name, required this.steps});
}

enum Delineator {
  row,
  r,
  step,
  custom,
}

Map<Delineator, String> delineatorMap = {
  Delineator.row : "(?i)row",
  Delineator.r : "R\d | R\s\d",
  Delineator.step : "(?i)step",
  Delineator.custom : "(?i)", // TODO CONCAT this with whatever the user input is
};

final scraperProvider = ChangeNotifierProvider((_) => ScraperState());

class ScraperState extends ChangeNotifier {
  bool isLoading = false;

  Delineator? delineator;
  List<String>? instructions;

  void handleDelineator(Delineator? value){
    delineator = value;
    notifyListeners();
  }

  Future createPattern() async {
    List<String> rawInstructions = [];
    List<String> newInstructions = [];
    final response = await http.Client().get(Uri.parse('https://stitch11.com/scarf-personal-growth/'));

    if (response.statusCode == 200){
      var patternSite = parser.parseFragment(response.body);
      String? patternSiteToString = patternSite.text;

      ///Splice by <strong>
      rawInstructions = patternSiteToString!.split('Row');
      rawInstructions.removeAt(0);
      rawInstructions.removeAt(rawInstructions.length - 1);
      LineSplitter ls = const LineSplitter();
      for(var item in rawInstructions){
        List<String> smallerItems = ls.convert(item);
        for (var smItem in smallerItems){
          newInstructions.add(smItem);
        }
      }
    }
    for (var item in newInstructions){
      print(item);
    }
    instructions = newInstructions;
    notifyListeners();

  }

  Future crochetPattern() async {
    List<String> rawInstructions = [];
    List<String> newInstructions = [];
    final response = await http.Client().get(Uri.parse('https://stitch11.com/scarf-personal-growth/'));

    if (response.statusCode == 200){
      var patternSite = parser.parseFragment(response.body);
      String? patternSiteToString = patternSite.text;

      // var document = parser.parseFragment(
      //     '<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
      // print(document.text);

      ///Splice by <strong>
      rawInstructions = patternSiteToString!.split('Row');
      rawInstructions.removeAt(0);
      rawInstructions.removeAt(rawInstructions.length - 1);
      LineSplitter ls = const LineSplitter();
      for(var item in rawInstructions){
        List<String> smallerItems = ls.convert(item);
        for (var smItem in smallerItems){
          newInstructions.add(smItem);
        }
      }
    }
    for (var item in newInstructions){
      print(item);
    }
    instructions = newInstructions;
    notifyListeners();
  }

}