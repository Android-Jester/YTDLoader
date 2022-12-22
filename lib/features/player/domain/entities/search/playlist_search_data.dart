part of 'search_data.dart';

class PlaylistSearchData extends Equatable {
  const PlaylistSearchData({
    required this.playlistId,
    required this.title,
    required this.playlistCount,
    required this.thumbnailURL,
  });

  final String playlistId;
  final String title;
  final int playlistCount;
  final String thumbnailURL;
  @override
  List<Object?> get props => [
        playlistId,
        title,
        playlistCount,
        thumbnailURL,
      ];
}
