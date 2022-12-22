part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class StateStarted extends SearchState {}

class SearchFailed extends SearchState {
  const SearchFailed(this.errorMessage);

  final String errorMessage;
}

class SearchLoading extends SearchState {}

class SearchInitial extends SearchState {
  const SearchInitial({required this.info});

  final List<SearchData> info;
}
