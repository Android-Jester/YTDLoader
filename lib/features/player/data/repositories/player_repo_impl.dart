import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, ChannelData>> channelInfo(String id) {
    // TODO: implement channelInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<VideoData>>> playlistInfo(String id) {
    // TODO: implement playlistInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<SearchData>>> querySearch(String query, SearchFilter filter) {
    // TODO: implement querySearch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<String>>> querySuggestions(String query) {
    // TODO: implement querySuggestions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VideoData>> videoInfo(String id) {
    // TODO: implement videoInfo
    throw UnimplementedError();
  }
}
