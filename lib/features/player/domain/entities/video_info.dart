class VideoInfo {
  VideoInfo({
    required this.title,
    required this.channelName,
    required this.length,
    required this.videoUrl,
    required this.imageUrl,
    required this.channelImageUrl,
    required this.isLive,
    required this.description,
  });

  final String title;
  final String description;
  final String channelName;
  final Duration length;
  final String videoUrl;
  final String imageUrl;
  final String channelImageUrl;
  final bool isLive;
}
