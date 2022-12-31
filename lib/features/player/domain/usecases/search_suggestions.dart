import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetSearchSuggestions extends ActivityUseCase<List<String>, String> {
  GetSearchSuggestions(this.repo);

  final PlayerRepo repo;
  @override
  Future<Either<Failure, List<String>>> call({required String params}) {
    return repo.querySuggestions(params);
  }
}
