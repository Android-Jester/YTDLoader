import 'package:bloc/bloc.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/usecases/search_videos.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.search}) : super(StateStarted()) {
    on<SearchingVideos>(getSearchResult);
  }

  final SearchVideos search;

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
}
