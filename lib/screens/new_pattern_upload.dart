import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pattern_tracker/state/scraper_state.dart';

class PatternUpload extends HookConsumerWidget {
  const PatternUpload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scraper = ref.watch(scraperProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name this pattern:'),
            TextFormField(),
            Text("Paste in the URL:"),
            TextFormField(),
            Text('Choose a pattern splice point: '),
            RadioListTile<Delineator>(
                value: Delineator.row,
                groupValue: scraper.delineator,
                onChanged: (Delineator? value) {}),
            RadioListTile<Delineator>(
                value: Delineator.r,
                groupValue: scraper.delineator,
                onChanged: (Delineator? value) {}),
            RadioListTile<Delineator>(
                value: Delineator.step,
                groupValue: scraper.delineator,
                onChanged: (Delineator? value) {}),
            RadioListTile<Delineator>(
                value: Delineator.custom,
                groupValue: scraper.delineator,
                onChanged: (Delineator? value) {
                  scraper.handleDelineator(value);
                }),
            if (scraper.delineator == Delineator.custom)
              TextFormField(),
          ],
        ),
      ),
    );
  }
}
