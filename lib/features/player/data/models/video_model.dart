import 'package:down_yt/features/player/domain/entities/video_info.dart';

class VideoSearchModel extends VideoInfo {
  VideoSearchModel({
    // Video Details
    required super.title,
    required super.length,
    required super.videoUrl,
    required super.imageUrl,
    required super.isLive,
    required super.description,

    // Channel Data
    required super.channelName,
    required super.channelImage,
  });
}
