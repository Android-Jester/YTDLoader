class VideoInfo {
  VideoInfo({
    required this.title,
    required this.description,
    required this.length,
    required this.videoUrl,
    required this.imageUrl,
    required this.isLive,
    required this.channelName,
    required this.channelImage,
  });

  // Video Detail
  final String title;
  final String description;
  final Duration length;
  final String videoUrl;
  final String imageUrl;
  final String channelName;
  final String channelImage;

  final bool isLive;
}
