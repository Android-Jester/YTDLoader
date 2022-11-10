import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:down_yt/features/player/presentation/pages/Homepage/Components/videos_list.dart';
import 'package:down_yt/features/player/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Components/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Body(),
    );
  }
}
