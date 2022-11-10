import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/domain/entities/comments.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';

abstract class PlayerRepo {
  Future<Either<Failure, VideoInfo>> getVideoInfo(String url);
  Future<Either<Failure, List<Comments>>> getComments(String videoUrl);
  Future<Either<Failure, List<VideoInfo>>> videoSearch(
    String query,
    VideoFilter filter,
    bool firstSearch,
  );
}
