import 'package:bloc/bloc.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/domain/usecases/search_videos.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.search}) : super(const SearchInitial(info: [])) {
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
      filter: event.filter,
      firstSearch: event.firstSearch,
    ));
    searchResult.fold(
      (failure) => emit(SearchFailed(failure.errorMessage)),
      (result) => emit(SearchInitial(info: result)),
    );
  }
}
