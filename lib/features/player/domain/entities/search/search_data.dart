import 'package:equatable/equatable.dart';

part 'channel_search_data.dart';
part 'playlist_search_data.dart';
part 'video_search_data.dart';

class SearchData extends Equatable {
  const SearchData({
    this.playlist,
    this.video,
    this.channel,
  });

  final PlaylistSearchData? playlist;
  final VideoSearchData? video;
  final ChannelSearchData? channel;
  @override
  List<Object?> get props => [
        playlist,
        video,
        channel,
      ];
}
