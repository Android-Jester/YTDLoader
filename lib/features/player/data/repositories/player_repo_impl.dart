import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/player/data/datasources/remote/player_data.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerRepoImpl implements PlayerRepo {
  PlayerRepoImpl({
    required this.internetStatus,
    required this.videoData,
  });

  final NetworkChecker internetStatus;
  final YoutubePlayerData videoData;
  @override
  Future<Either<Failure, List<VideoInfo>>> videoSearch(
    String query,
    SearchFilter filter,
  ) async {
    try {
      if (await internetStatus.isConnected) {
        final searchData = await videoData.searchVideos(query, filter);
        return Right(searchData);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(VideoSearchFailure());
    }
  }
}
