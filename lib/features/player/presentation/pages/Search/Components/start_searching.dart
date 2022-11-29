import 'package:down_yt/features/player/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class StartSearching extends StatelessWidget {
  const StartSearching({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Please Start by Searching',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8).copyWith(top: 24, bottom: 5),
            child: const SearchBar(),
          ),
        ],
      ),
    );
  }
}
