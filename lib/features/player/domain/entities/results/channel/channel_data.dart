import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:equatable/equatable.dart';

part 'associated_channels.dart';
part 'channel_about.dart';

class ChannelData extends Equatable {
  const ChannelData({
    required this.channelName,
    required this.channelURL,
    this.subscriberCount,
    required this.logoUrl,
    required this.bannerUrl,
    required this.about,
    required this.videos,
    this.playlists,
  });

  final String channelName;
  final String channelURL;
  final int? subscriberCount;
  final String logoUrl;
  final String bannerUrl;
  final AboutChannel about;
  final List<VideoData> videos;
  final List<List<VideoData>>? playlists;

  @override
  List<Object?> get props => [
        channelName,
        channelURL,
        subscriberCount,
        logoUrl,
        bannerUrl,
        about,
        videos,
        playlists,
      ];
}
