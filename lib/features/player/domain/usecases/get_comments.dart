import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/comments.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetVideoComments extends ActivityUseCase<List<Comments>, String> {
  GetVideoComments(this.repo);

  final PlayerRepo repo;
  @override
  Future<Either<Failure, List<Comments>>> call({required String params}) {
    return repo.getComments(params);
  }
}
