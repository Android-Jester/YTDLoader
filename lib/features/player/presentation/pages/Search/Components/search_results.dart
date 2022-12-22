import 'package:down_yt/features/player/domain/entities/video_search_data.dart';
import 'package:down_yt/features/player/presentation/pages/Search/Components/videos_list.dart';
import 'package:down_yt/features/player/presentation/widgets/mini_player.dart';
import 'package:down_yt/features/player/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.info});
  final List<SearchInfo> info;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8).copyWith(top: 24, bottom: 5),
              child: const SearchBar(),
            ),
            const SizedBox(height: 15),
            Expanded(child: VideoList(info: info)),
          ],
        ),
        const MiniPlayer()
      ],
    );
  }
}
