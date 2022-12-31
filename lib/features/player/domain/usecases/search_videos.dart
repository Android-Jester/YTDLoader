import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchVideos extends ActivityUseCase<Stream<SearchData>, VideoSearchQuery> {
  SearchVideos(this.repo);
  final PlayerRepo repo;
  @override
  Future<Either<Failure, Stream<SearchData>>> call({
    required VideoSearchQuery params,
  }) {
    return repo.querySearch(
      params.query,
      params.filter,
    );
  }
}

class VideoSearchQuery extends Equatable {
  const VideoSearchQuery(
    this.query, {
    required this.filter,
  });
  final String query;
  final SearchFilter filter;
  @override
  List<Object?> get props => [];
}
