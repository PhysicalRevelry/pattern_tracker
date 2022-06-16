import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

enum Delineator {
  row,
  r,
  step,
  custom,
}

final scraperProvider = ChangeNotifierProvider((_) => ScraperState());

class ScraperState extends ChangeNotifier {
  bool isLoading = false;

  Delineator? delineator = Delineator.row;
  List<String>? instructions;

  void handleDelineator(Delineator? value){
    delineator = value;
    notifyListeners();
  }

  Future crochetPattern() async {
    List<String> rawInstructions = [];
    List<String> newInstructions = [];
    final response = await http.Client().get(Uri.parse('https://stitch11.com/scarf-personal-growth/'));

    if (response.statusCode == 200){
      var patternSite = parser.parseFragment(response.body);
      String? patternSiteToString = patternSite.text;
      // print(patternSiteToString);

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