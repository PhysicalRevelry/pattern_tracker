import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pattern_tracker/state/scraper_state.dart';

class PatternScraper extends HookConsumerWidget {
  const PatternScraper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scraper = ref.watch(scraperProvider);

    List<Widget> buildCards() {
      List<Widget> cards = [];
      if (scraper.instructions != null) {
        for (var item in scraper.instructions!) {
          Widget card = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.deepPurple,
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
          cards.add(card);
        }
      }
      return cards;
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...buildCards(),
                MaterialButton(
                  onPressed: () async {
                    await scraper.crochetPattern();
                  },
                  color: Colors.green,
                  child: const Text(
                    'Scrap Data',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
