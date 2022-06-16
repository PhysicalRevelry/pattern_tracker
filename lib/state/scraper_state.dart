import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

final scraperProvider = ChangeNotifierProvider((_) => ScraperState());

class ScraperState extends ChangeNotifier {
  String result1 = "Result 1";
  String result2 = "Result 2";
  String result3 = "Result 3";

  bool isLoading = false;

  List<String>? instructions;

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
        // if (item.contains('Step')){
        //   List<String> steps = item.split('Step');
        //   for (var step in steps){
        //     newInstructions.add(step);
        //   }
        // } else {
        //   newInstructions.add(item);
        // }
      }
    }
    for (var item in newInstructions){
      print(item);
    }
    instructions = newInstructions;
    notifyListeners();
  }

  Future<List<String>> extractData() async {
    // Getting the response from the targeted url
    final response =
    await http.Client().get(Uri.parse('https://www.geeksforgeeks.org'));
    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {
        // Scraping the first article title
        var responseString1 = document
            .getElementsByClassName('articles-list')[0]
            .children[0]
            .children[0]
            .children[0];
        print(responseString1.text.trim());

        // Scraping second article
        var responseString2 = document
            .getElementsByClassName('articles-list')[0]
            .children[1]
            .children[0]
            .children[0];
        print(responseString2.text.trim());

        // Scraping third article title
        var responseString3 = document
            .getElementsByClassName('articles-list')[0]
            .children[2]
            .children[0]
            .children[0];
        print(responseString3.text.trim());

        // var responseString4 = document.get

        // Converting the extracted titles into string and returning a list of strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim()
        ];
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}'];
    }
  }


  void scraperResults() async {
    isLoading = true;
    notifyListeners();
    // Awaiting for the web scraping function to complete
    final response = await extractData();
    // Setting the received string to be displayed
    result1 = response[0];
    result2 = response[1];
    result3 = response[2];
    isLoading = false;
    notifyListeners();
  }


}