import 'package:down_yt/features/player/data/datasources/remote/player_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final data = YoutubePlayerDataImpl();
void main() async {
  test('Search Query Produced all items', () async {
    final listed = await data
        .searchYoutube(
          query: 'flutter',
          filter: TypeFilters.playlist,
        )
        .take(10)
        .toList();
    print('Data: ${listed.first.playlist?.title}');
  });

  test('Playlist items', () async {
    final playlistdata = await data.getPlaylistVideos('PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2');
    final result = await playlistdata.length;

    expect(result, 24);
  });

  test('First Value', () async {
    final playlistdata = await data.getPlaylistVideos('PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2');
    print('Broadcast: ${playlistdata.isBroadcast}');
    final result = await playlistdata.length;
    print('Playlist Length: $result');
    await for (final item in playlistdata) {
      print('Video Title: ${item.title}');
    }
  });
}
