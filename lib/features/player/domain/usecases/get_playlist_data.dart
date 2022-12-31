import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetPlayListData extends ActivityUseCase<Stream<VideoData>, String> {
  GetPlayListData(this.repo);

  final PlayerRepo repo;

  @override
  Future<Either<Failure, Stream<VideoData>>> call({required String params}) {
    return repo.playlistInfo(params);
  }
}
