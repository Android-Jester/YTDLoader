import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class InitialFeed extends ActivityUseCase<List<SearchData>, void> {
  InitialFeed(this.repo);

  final PlayerRepo repo;
  @override
  Future<Either<Failure, List<SearchData>>> call({required void params}) {
    return repo.getFeeds();
  }
}
