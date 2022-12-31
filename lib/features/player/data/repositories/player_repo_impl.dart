import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/player/data/datasources/remote/player_data.dart';
import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerImpl extends PlayerRepo {
  YoutubePlayerImpl({
    required this.remoteData,
    required this.internetStatus,
  });

  final YoutubePlayerData remoteData;
  final NetworkChecker internetStatus;

  @override
  Future<Either<Failure, ChannelData>> channelInfo(String id) async {
    try {
      if (await internetStatus.isConnected) {
        final channelData = await remoteData.getChannelData(id);
        return Right(channelData);
      } else {
        return const Left(NetworkFailure('Unable to obtain channel Data'));
      }
    } on ObtainingChannelDataException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }

  @override
  Future<Either<Failure, Stream<VideoData>>> playlistInfo(String id) async {
    try {
      if (await internetStatus.isConnected) {
        final playlistData = await remoteData.getPlaylistVideos(id);
        return Right(playlistData);
      } else {
        return const Left(NetworkFailure('Unable to obtain playlist Data'));
      }
    } on ObtainingPlaylistDataException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }

  @override
  Future<Either<Failure, Stream<SearchData>>> querySearch(
      String query, SearchFilter filter) async {
    try {
      if (await internetStatus.isConnected) {
        final searchData =
            await remoteData.searchYoutube(query: query, filter: filter);
        return Right(searchData);
      } else {
        return const Left(NetworkFailure('Unable to obtain search data'));
      }
    } on SearchException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }

  @override
  Future<Either<Failure, List<String>>> querySuggestions(String query) async {
    try {
      if (await internetStatus.isConnected) {
        final searchData = await remoteData.getSuggestions(query);
        return Right(searchData);
      } else {
        return const Left(NetworkFailure('unable to obtain suggestions'));
      }
    } on SearchException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }

  @override
  Future<Either<Failure, VideoData>> videoInfo(String id) async {
    try {
      if (await internetStatus.isConnected) {
        final videoData = await remoteData.getVideosData(id);
        return Right(videoData);
      } else {
        return const Left(NetworkFailure('unable to obtain videoData'));
      }
    } on ObtainingVideoDataException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }

  @override
  Future<Either<Failure, List<SearchData>>> getFeeds() async {
    try {
      print('Internet Status: ${await internetStatus.isConnected}');
      if (await internetStatus.isConnected) {
        final data = await remoteData.trendingFeed();
        print('Repo Data: ${data.toString()}');
        return Right(data);
      } else {
        return const Left(DataFailure('Unable to acquire Data'));
      }
    } on ObtainingChannelDataException catch (err) {
      return Left(DataFailure(err.errormessage));
    }
  }
}
