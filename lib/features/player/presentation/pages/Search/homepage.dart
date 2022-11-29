import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:down_yt/features/player/presentation/pages/Search/Components/search_results.dart';
import 'package:down_yt/features/player/presentation/pages/Search/Components/start_searching.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Components/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = 'search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Body(),
    );
  }
}
