import 'package:down_yt/features/player/domain/entities/video_info.dart';

class SearchModel extends SearchInfo {
  SearchModel({
    // Video Details
    required super.itemTitle,
    super.description,
    super.videoLength,
    required super.itemUrl,
    required super.imageUrl,
    super.isLive,

    // Channel Data
    super.channelName,
    super.channelImage,

    // PlayList Data
    super.isPlayList,
    super.playListLength,
    super.playlistId,
  });
}
