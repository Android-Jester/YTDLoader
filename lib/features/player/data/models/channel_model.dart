import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';

class ChannelModel extends ChannelData {
  const ChannelModel({
    required super.channelName,
    required super.channelURL,
    required super.logoUrl,
    required super.bannerUrl,
    required super.about,
    required super.videos,
    super.playlists,
  });
}
