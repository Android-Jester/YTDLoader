part of 'search_data.dart';

class VideoSearchData extends Equatable {
  const VideoSearchData({
    required this.title,
    required this.description,
    required this.duration,
    required this.videoId,
    required this.channelId,
    required this.isLive,
    required this.channelAuthor,
    required this.thumbnailUrl,
    required this.viewCount,
  });

  final String title;
  final String description;
  final String duration;
  final String videoId;
  final String channelId;
  final bool isLive;
  final String channelAuthor;
  final String thumbnailUrl;
  final int viewCount;
  @override
  List<Object?> get props => [
        title,
        description,
        duration,
        videoId,
        isLive,
        channelAuthor,
        thumbnailUrl,
        viewCount,
      ];
}
