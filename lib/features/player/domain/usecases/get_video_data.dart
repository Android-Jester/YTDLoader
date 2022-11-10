import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetVideoData extends ActivityUseCase<VideoInfo, String> {
  GetVideoData(this.repo);

  final PlayerRepo repo;
  @override
  Future<Either<Failure, VideoInfo>> call({required String params}) {
    return repo.getVideoInfo(params);
  }
}
