import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class PlayerRepo {
  Future<Either<Failure, List<VideoInfo>>> videoSearch(
    String query,
    SearchFilter filter,
  );
}
