import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pattern_tracker/screens/pattern_splitter.dart';
import 'package:pattern_tracker/state/scraper_state.dart';

class PatternUpload extends HookConsumerWidget {
  const PatternUpload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scraper = ref.watch(scraperProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pattern Tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Name this pattern:'),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Text("Paste in the URL:"),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Please include the http: or https:'),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Choose a pattern splice point: '),
              RadioListTile<Delineator>(
                  title: Text('Row'),
                  value: Delineator.row,
                  groupValue: scraper.delineator,
                  onChanged: (Delineator? value) {
                    scraper.handleDelineator(value);
                  }),
              RadioListTile<Delineator>(
                  title: Text('R'),
                  value: Delineator.r,
                  groupValue: scraper.delineator,
                  onChanged: (Delineator? value) {
                    scraper.handleDelineator(value);
                  }),
              RadioListTile<Delineator>(
                  title: Text('Step'),
                  value: Delineator.step,
                  groupValue: scraper.delineator,
                  onChanged: (Delineator? value) {
                    scraper.handleDelineator(value);
                  }),
              RadioListTile<Delineator>(
                  title: Text('Custom'),
                  value: Delineator.custom,
                  groupValue: scraper.delineator,
                  onChanged: (Delineator? value) {
                    scraper.handleDelineator(value);
                  }),
              if (scraper.delineator == Delineator.custom)
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter something unique'),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: scraper.delineator == null
                      ? Colors.grey
                      : Colors.deepPurple,
                ),
                onPressed: () {
                  if (scraper.delineator == null) {
                    return;
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatternSplitter()));
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
