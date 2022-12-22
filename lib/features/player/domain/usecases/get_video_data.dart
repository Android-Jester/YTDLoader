import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetVideoData extends ActivityUseCase<VideoData, String> {
  GetVideoData({
    required this.repository,
  });

  final PlayerRepo repository;
  @override
  Future<Either<Failure, VideoData>> call({required String params}) {
    return repository.videoInfo(params);
  }
}
