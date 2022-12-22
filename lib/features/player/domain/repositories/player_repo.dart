import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/features/player/domain/entities/video_search_data.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class PlayerRepo {
  Future<Either<Failure, List<SearchInfo>>> videoSearch(
    String query,
    SearchFilter filter,
  );
}
