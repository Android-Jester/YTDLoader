import 'package:down_yt/features/player/domain/entities/video_info.dart';

class VideoModel extends VideoInfo {
  VideoModel({
    required super.channelImageUrl,
    required super.title,
    required super.channelName,
    required super.length,
    required super.videoUrl,
    required super.imageUrl,
    required super.isLive,
    required super.description,
  });
}
