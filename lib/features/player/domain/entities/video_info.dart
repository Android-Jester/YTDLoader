class SearchInfo {
  SearchInfo({
    required this.itemTitle,
    this.description = '',
    this.videoLength = Duration.zero,
    required this.itemUrl,
    required this.imageUrl,
    this.isLive = false,
    this.channelName = '',
    this.channelImage = '',
    this.isPlayList = false,
    this.playListLength = 0,
    this.playlistId = '',
  });

  // Video Detail
  final String itemTitle;
  final String description;
  final Duration videoLength;
  final String itemUrl;
  final String imageUrl;
  final String channelName;
  final String channelImage;
  final bool isLive;

  // PlayList Details
  final bool isPlayList;
  final int playListLength;
  final String playlistId;
}
