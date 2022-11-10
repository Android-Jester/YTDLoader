import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';

abstract class ActivityUseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class StreamUsecase<Type, Params> {
  Stream<Either<Failure, Type>> call({required Params params});
}

class NoParams {}
