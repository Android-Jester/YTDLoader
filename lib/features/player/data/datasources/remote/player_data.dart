import 'package:built_collection/built_collection.dart';
import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/data/models/channel_model.dart';
import 'package:down_yt/features/player/data/models/search_model.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:piped_api/piped_api.dart' as pip;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubePlayerData {
  Stream<SearchModel> searchYoutube(
      {required String query, required SearchFilter filter});
  Future<List<String>> getSuggestions(String query);
  Future<Stream<VideoModel>> getPlaylistVideos(String id);
  Future<VideoModel> getVideosData(String id);
  Future<ChannelModel> getChannelData(String id);
  Future<List<SearchModel>> trendingFeed();
}

class YoutubePlayerDataImpl implements YoutubePlayerData {
  @override
  Stream<SearchModel> searchYoutube({
    required String query,
    SearchFilter filter = SortFilters.relevance,
  }) async* {
    try {
      final searchAPI = youtube.search;
      var searchResult = await searchAPI.searchContent(query, filter: filter);
      final secondResult = await searchResult.nextPage();
      var firstCount = true;
      while (secondResult != null) {
        // obtain the search Result
        if (firstCount) {
          for (var item in searchResult) {
            if (item is SearchVideo) {
              yield SearchModel(
                video: VideoSearchData(
                  title: item.title,
                  description: item.description,
                  duration: item.duration,
                  videoId: item.id.value,
                  channelId: item.channelId,
                  isLive: item.isLive,
                  channelAuthor: item.author,
                  thumbnailUrl: item.thumbnails
                      .firstWhere((element) => element.height > 250)
                      .url
                      .path,
                  viewCount: item.viewCount,
                ),
              );
            } else if (item is SearchPlaylist) {
              yield SearchModel(
                playlist: PlaylistSearchData(
                  title: item.playlistTitle,
                  playlistCount: item.playlistVideoCount,
                  playlistId: item.playlistId.value,
                  thumbnailURL: item.thumbnails.first.url.path,
                ),
              );
            } else if (item is SearchChannel) {
              yield SearchModel(
                channel: ChannelSearchData(
                  channelName: item.name,
                  channelDescription: item.description,
                  channelId: item.id.value,
                  videoCount: item.videoCount,
                ),
              );
            }
          }
          firstCount = false;
        } else {
          searchResult = secondResult;
          for (var item in searchResult) {
            if (item is SearchVideo) {
              yield SearchModel(
                video: VideoSearchData(
                  title: item.title,
                  description: item.description,
                  duration: item.duration,
                  videoId: item.id.value,
                  channelId: item.channelId,
                  isLive: item.isLive,
                  channelAuthor: item.author,
                  thumbnailUrl: item.thumbnails.first.url.path,
                  viewCount: item.viewCount,
                ),
              );
            } else if (item is SearchPlaylist) {
              print('Playlist2 Item: ${item.toString()}');

              yield SearchModel(
                playlist: PlaylistSearchData(
                  title: item.playlistTitle,
                  playlistCount: item.playlistVideoCount,
                  playlistId: item.playlistId.value,
                  thumbnailURL: item.thumbnails.first.url.path,
                ),
              );
            } else if (item is SearchChannel) {
              yield SearchModel(
                channel: ChannelSearchData(
                  channelName: item.name,
                  channelDescription: item.description,
                  channelId: item.id.value,
                  videoCount: item.videoCount,
                ),
              );
            }
          }
          firstCount = false;
        }
      }
    } catch (err) {
      print('err: ${err.runtimeType}');
      throw SearchException(
          'unable to obtain search data \n Exception: ${err.runtimeType}');
    }
  }

  @override
  Future<List<String>> getSuggestions(String query) async {
    try {
      return youtube.search.getQuerySuggestions(query);
    } catch (err) {
      throw SearchException(
          'unable to obtain search suggestion \n Exception: ${err.runtimeType}');
    }
  }

  @override
  Future<Stream<VideoModel>> getPlaylistVideos(String id) async {
    try {
      final playlist = youtube.playlists.getVideos(id);
      return playlist
          .map<VideoModel>(
            (Video video) => VideoModel(
              videoId: video.id.value,
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
          .asBroadcastStream();
      // ..listen((Video video) async* {
      //   yield VideoModel(
      //     videoId: video.id.value,
      //     title: video.title,
      //     channelName: video.author,
      //     channelId: video.channelId.value,
      //     description: video.description,
      //     duration: video.duration,
      //     uploadDate: video.uploadDate,
      //     isLive: video.isLive,
      //     likeCount: video.engagement.likeCount,
      //     dislikeCount: video.engagement.dislikeCount,
      //     viewCount: video.engagement.viewCount,
      //   );
      // });
      // .map(
      //   (video) => VideoModel(
      //     videoId: video.id.value,
      //     title: video.title,
      //     channelName: video.author,
      //     channelId: video.channelId.value,
      //     description: video.description,
      //     duration: video.duration,
      //     uploadDate: video.uploadDate,
      //     isLive: video.isLive,
      //     likeCount: video.engagement.likeCount,
      //     dislikeCount: video.engagement.dislikeCount,
      //     viewCount: video.engagement.viewCount,
      //   ),
      // ).asBroadcastStream();

    } catch (err) {
      throw ObtainingPlaylistDataException(
          'unable to acquire playlist data \n Exception: ${err.runtimeType}');
    }
  }

  @override
  Future<VideoModel> getVideosData(String id) async {
    try {
      final video = await youtube.videos.get(id);
      return VideoModel(
        videoId: video.id.value,
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
    } catch (err) {
      throw ObtainingVideoDataException(
          'unable to acquire videodata\n Exception: ${err.runtimeType}');
    }
  }

  @override
  Future<ChannelModel> getChannelData(String id) async {
    try {
      final channel = await youtube.channels.get(id);
      final channelUploads =
          await youtube.channels.getUploads(id).take(20).toList();
      final about = await youtube.channels.getAboutPage(id);
      final videos = channelUploads
          .map(
            (video) => VideoData(
              videoId: video.id.value,
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
    } catch (err) {
      throw ObtainingChannelDataException(
          'unable to acquire channel data\n Exception: ${err.runtimeType}');
    }
  }

  @override
  Future<List<SearchModel>> trendingFeed() async {
    try {
      var api = pip.PipedApi().getFeedApi();
      final channels = BuiltList<String>(
          ['UCs6KfncB4OV6Vug4o_bzijg', 'UClcE-kVhqyiHCcjYwcpfj9w']);
      final result = await api.feedUnauthenticated(
        channels: channels,
      );

      final searchList = result.data?.map<SearchModel>((pip.StreamItem video) {
        return SearchModel(
          video: VideoSearchData(
            title: video.title,
            description: '',
            duration: Duration(seconds: video.duration).toString(),
            videoId: video.url.split('=').last,
            channelId: (video.uploaderUrl?.split('=').last)!,
            isLive: video.duration > 60 * 60 * 24 * 3,
            channelAuthor: video.uploaderName!,
            thumbnailUrl: video.thumbnail,
            viewCount: video.views!,
          ),
        );
      }).toList();
      return searchList!;
    } catch (err) {
      print('err: ${err.runtimeType.toString()}');
      throw ObtainingChannelDataException(
          'unable to acquire feed data\n Exception: ${err.runtimeType}');
    }
  }
}
