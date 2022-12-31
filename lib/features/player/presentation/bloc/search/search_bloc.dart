import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/domain/entities/search/search_data.dart';
import 'package:down_yt/features/player/domain/usecases/search_videos.dart';
import 'package:down_yt/features/player/domain/usecases/trending_feed.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.search, required this.feedData})
      : super(StateStarted()) {
    on<SearchingVideos>(getSearchResult);
    on<CallInitialFeed>(_getFeed);
  }

  final SearchVideos search;
  final InitialFeed feedData;

  Future<void> getSearchResult(
    SearchingVideos event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    final searchResult = await search(
      params: VideoSearchQuery(
        event.searchQuery,
        filter: TypeFilters.video,
      ),
    );
    searchResult.fold(
      (failure) => emit(SearchFailed(failure.errorMessage)),
      (result) => emit(SearchInitial(info: result)),
    );
  }

  FutureOr<void> _getFeed(
    CallInitialFeed event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    final result = await feedData(params: null);
    result.fold(
      (failure) => emit(SearchFailed(failure.errorMessage)),
      (data) => emit(InitialFeedState(info: data)),
    );
  }
}
