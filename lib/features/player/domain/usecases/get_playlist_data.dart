import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetPlaylistData extends ActivityUseCase<List<VideoData>, String> {
  GetPlaylistData({
    required this.repository,
  });

  final PlayerRepo repository;
  @override
  Future<Either<Failure, List<VideoData>>> call({required String params}) {
    return repository.playlistInfo(params);
  }
}
