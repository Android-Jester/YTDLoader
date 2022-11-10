import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';
import 'package:equatable/equatable.dart';

class SearchVideos extends ActivityUseCase<List<VideoInfo>, VideoSearchQuery> {
  SearchVideos(this.repo);
  final PlayerRepo repo;
  @override
  Future<Either<Failure, List<VideoInfo>>> call({
    required VideoSearchQuery params,
  }) {
    return repo.videoSearch(params.query, params.filter, params.firstSearch,);
  }
}

class VideoSearchQuery extends Equatable {
  const VideoSearchQuery(
    this.query, {
    required this.filter,
    required this.firstSearch,
  });
  final String query;
  final VideoFilter filter;
  final bool firstSearch;
  @override
  List<Object?> get props => [];
}
