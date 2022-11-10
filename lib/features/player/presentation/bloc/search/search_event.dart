part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchingVideos extends SearchEvent {
  const SearchingVideos(this.searchQuery,
      {this.filter = VideoFilter.video, this.firstSearch = true,});

  final String searchQuery;
  final VideoFilter filter;
  final bool firstSearch;
}
