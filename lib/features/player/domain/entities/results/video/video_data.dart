import 'package:equatable/equatable.dart';

class VideoData extends Equatable {
  const VideoData({
    required this.videoId,
    required this.title,
    required this.channelName,
    required this.channelId,
    required this.description,
    required this.duration,
    required this.uploadDate,
    required this.isLive,
    required this.likeCount,
    required this.dislikeCount,
    required this.viewCount,
  });

  final String title;
  final String videoId;
  final String channelName;
  final String channelId;
  final String description;
  final Duration? duration;
  final DateTime? uploadDate;
  final bool isLive;
  final int? likeCount;
  final int? dislikeCount;
  final int? viewCount;

  @override
  List<Object?> get props => [
        title,
        channelName,
        channelId,
        description,
        duration,
        uploadDate,
        isLive,
        likeCount,
        dislikeCount,
        viewCount,
      ];
}
