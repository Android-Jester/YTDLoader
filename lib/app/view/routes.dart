import 'package:down_yt/features/player/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  HomeScreen.id: (context) => const HomeScreen(),
};
