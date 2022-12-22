import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';

class VideoModel extends VideoData {
  const VideoModel({
    required super.videoId,
    required super.title,
    required super.channelName,
    required super.channelId,
    required super.description,
    super.duration,
    super.uploadDate,
    required super.isLive,
    super.likeCount,
    super.dislikeCount,
    super.viewCount,
  });
}
