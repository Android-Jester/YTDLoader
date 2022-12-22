import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/data/models/channel_model.dart';
import 'package:down_yt/features/player/data/models/search_model.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubePlayerData {
  Future<List<SearchModel>> searchYoutube({required String query, required SearchFilter filter});
  Future<List<String>> getSuggestions(String query);
  Future<List<VideoModel>> getPlaylistVideos(String id);
  Future<VideoModel> getVideosData(String id);
  Future<ChannelModel> getChannelData(String id);
}

class YoutubePlayerDataImpl implements YoutubePlayerData {
  @override
  Future<List<SearchModel>> searchYoutube({required String query, required SearchFilter filter}) async {
    try {
      final searchAPI = youtube.search;
      final resultList = <SearchModel>[];
      final searchResult = await searchAPI.searchContent(query, filter: filter);

      for (var item in searchResult) {
        if (item is SearchVideo) {
          resultList.add(
            SearchModel(
              video: VideoSearchData(
                title: item.title,
                description: item.description,
                duration: item.duration,
                videoId: item.id.value,
                channelId: item.channelId,
                isLive: item.isLive,
                channelAuthor: item.author,
                thumbnailUrl: item.thumbnails.firstWhere((element) => element.height > 250).url.path,
                viewCount: item.viewCount,
              ),
            ),
          );
        } else if (item is SearchPlaylist) {
          resultList.add(
            SearchModel(
              playlist: PlaylistSearchData(
                title: item.playlistTitle,
                playlistCount: item.playlistVideoCount,
                playlistId: item.playlistId.value,
                thumbnailURL: item.thumbnails.firstWhere((element) => element.height > 250).url.path,
              ),
            ),
          );
        } else if (item is SearchChannel) {
          resultList.add(SearchModel(
            channel: ChannelSearchData(channelName: item.name, channelDescription: item.description, channelId: item.id.value, videoCount: item.videoCount),
          ));
        }
      }
      return resultList;
    } catch (err) {
      throw Exception('unabled to obtain search data');
    }
  }

  @override
  Future<List<String>> getSuggestions(String query) async {
    try {
      return youtube.search.getQuerySuggestions(query);
    } catch (err) {
      throw Exception('unable to get data');
    }
  }

  @override
  Future<List<VideoModel>> getPlaylistVideos(String id) async {
    final playlist = await youtube.playlists.getVideos(id).take(20).toList();
    final playlistData = playlist
        .map(
          (video) => VideoModel(
            title: video.title,
            channelName: video.author,
            channelId: video.channelId.value,
            description: video.description,
            duration: video.duration,
            uploadDate: video.uploadDate,
            isLive: video.isLive,
            likeCount: video.engagement.likeCount,
            dislikeCount: video.engagement.dislikeCount,
            viewCount: video.engagement.viewCount,
          ),
        )
        .toList();

    return playlistData;
  }

  @override
  Future<VideoModel> getVideosData(String id) async {
    final video = await youtube.videos.get(id);
    return VideoModel(
      title: video.title,
      channelName: video.author,
      channelId: video.channelId.value,
      description: video.description,
      duration: video.duration,
      uploadDate: video.uploadDate,
      isLive: video.isLive,
      likeCount: video.engagement.likeCount,
      dislikeCount: video.engagement.dislikeCount,
      viewCount: video.engagement.viewCount,
    );
  }

  @override
  Future<ChannelModel> getChannelData(String id) async {
    final channel = await youtube.channels.get(id);
    final channelUploads = await youtube.channels.getUploads(id).take(20).toList();
    final about = await youtube.channels.getAboutPage(id);
    final videos = channelUploads
        .map(
          (video) => VideoData(
            title: video.title,
            channelName: video.author,
            channelId: video.channelId.value,
            description: video.description,
            duration: video.duration,
            uploadDate: video.uploadDate,
            isLive: video.isLive,
            likeCount: video.engagement.likeCount,
            dislikeCount: video.engagement.dislikeCount,
            viewCount: video.engagement.viewCount,
          ),
        )
        .toList();

    return ChannelModel(
      channelName: channel.title,
      channelURL: channel.url,
      logoUrl: channel.logoUrl,
      bannerUrl: channel.bannerUrl,
      about: AboutChannel(
        description: about.description,
        joinDate: about.joinDate,
        sourceCountry: about.country,
        associatedChannels: about.channelLinks
            .map(
              (e) => AssociatedChannel(
                channelIcon: e.icon.path,
                channelName: e.title,
                channelUrl: e.url.path,
              ),
            )
            .toList(),
      ),
      videos: videos,
    );
  }
}
