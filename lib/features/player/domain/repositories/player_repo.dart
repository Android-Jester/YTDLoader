import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class PlayerRepo {
  Future<Either<Failure, Stream<SearchData>>> querySearch(
    String query,
    SearchFilter filter,
  );
  Future<Either<Failure, List<String>>> querySuggestions(String query);
  Future<Either<Failure, VideoData>> videoInfo(String id);
  Future<Either<Failure, Stream<VideoData>>> playlistInfo(String id);
  Future<Either<Failure, ChannelData>> channelInfo(String id);
  Future<Either<Failure, List<SearchData>>> getFeeds();
}
