import 'package:down_yt/features/player/presentation/pages/Homepage/homepage.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  HomePage.id: (context) => const HomePage(),
  // SearchScreen.id: (_) => const SearchScreen(),
};
