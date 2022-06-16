import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InstructionCard extends HookConsumerWidget {
  const InstructionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Split')),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.close),
              )
            ],
          ),
          Text('Instructions Go Here'),
        ],
      ),
    );
  }
}
