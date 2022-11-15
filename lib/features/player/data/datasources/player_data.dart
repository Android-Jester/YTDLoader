import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/data/models/comment_data.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubePlayerData {
  Future<VideoModel> getVideoData(String url);
  Future<List<CommentsModel>> getComments(String videoUrl);
  // Future<Stream<List<int>>> streamVideo(String url);
  Future<List<VideoModel>> searchVideos(
    String query,
    VideoFilter filter,
    bool firstSearch,
  );
}

class YoutubePlayerDataImpl implements YoutubePlayerData {
  @override
  Future<VideoModel> getVideoData(String url) async {
    try {
      final video = await youtube.videos.get(url);
      final videoData = VideoModel(
        channelImageUrl: video.channelId.value,
        isLive: video.isLive,
        title: video.title,
        channelName: video.channelId.value,
        length: video.duration!,
        videoUrl: video.url,
        imageUrl: video.thumbnails.highResUrl,
        description: video.description,
      );
      return videoData;
    } catch (e) {
      throw VideoDataException();
    }
  }

  @override
  Future<List<CommentsModel>> getComments(String videoUrl) async {
    try {
      final video = await youtube.videos.get(videoUrl);
      final comments = await youtube.videos.commentsClient.getComments(video);
      final commentList = comments
          ?.map(
            (com) => CommentsModel(
              commenterName: com.author,
              comment: com.text,
            ),
          )
          .toList();
      return commentList!;
    } catch (e) {
      throw VideoDataException();
    }
  }

  @override
  Future<List<VideoModel>> searchVideos(
    String query,
    VideoFilter filter,
    bool firstSearch,
  ) async {
    // Get filter result
    late SearchFilter searchFilter;

    switch (filter) {
      case VideoFilter.video:
        searchFilter = TypeFilters.video;
        break;
      case VideoFilter.playList:
        searchFilter = TypeFilters.playlist;
        break;
      case VideoFilter.channel:
        searchFilter = TypeFilters.channel;
        break;
    }

    try {
      // Obtain List from Youtube
      var searchData = await youtube.search.search(query, filter: searchFilter);

      // checks if this is the first search
      if (!firstSearch) searchData = (await searchData.nextPage())!;
      final videoDataList = <VideoModel>[];
      for (final result in searchData) {
        final channelImage = (await youtube.channels.get(result.channelId.value)).logoUrl;
        videoDataList.add(
          VideoModel(
            channelImageUrl: channelImage,
            title: result.title,
            channelName: result.author,
            length: result.duration!,
            videoUrl: result.url,
            description: result.description,
            imageUrl: result.thumbnails.highResUrl,
            isLive: result.isLive,
          ),
        );
      }
      return videoDataList;
    } catch (e) {
      throw VideoDataException();
    }
  }
}
