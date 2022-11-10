import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/player/data/datasources/player_data.dart';
import 'package:down_yt/features/player/domain/entities/comments.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class PlayerRepoImpl implements PlayerRepo {
  PlayerRepoImpl({
    required this.internetStatus,
    required this.videoData,
  });

  final NetworkChecker internetStatus;
  final YoutubePlayerData videoData;
  @override
  Future<Either<Failure, List<Comments>>> getComments(String videoUrl) async {
    try {
      if (await internetStatus.isConnected) {
        final commentData = await videoData.getComments(videoUrl);
        return Right(commentData);
      } else {
        throw ConnectionUnsuccessfulException();
      }
    } catch (e) {
      return Left(VideoDataGetFailure());
    }
  }

  @override
  Future<Either<Failure, VideoInfo>> getVideoInfo(String url) async {
    try {
      if (await internetStatus.isConnected) {
        final videoInfo = await videoData.getVideoData(url);
        return Right(videoInfo);
      } else {
        throw ConnectionUnsuccessfulException();
      }
    } catch (e) {
      return Left(VideoDataGetFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoInfo>>> videoSearch(String query, VideoFilter filter, bool firstSearch,) async {
    try {
      if (await internetStatus.isConnected) {
        final searchResultData = await videoData.searchVideos(query, filter, firstSearch);
        return Right(searchResultData);
      } else {
        throw ConnectionUnsuccessfulException();
      }
    } catch (e) {
      return Left(VideoSearchFailure());
    }
  }
}
