part of 'failures.dart';

// Downloader Failures
class DownloadFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String get errorMessage => 'Failed to acquire file';
}

class DownloadInfoFailure implements Failure {
  @override
  String get errorMessage => 'Failed to acquire download info';

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => false;
}

// Player Failures

class DataFailure extends Failure {
  const DataFailure(super.errorMessage);
}

class SearchFailure extends Failure {
  const SearchFailure(super.errorMessage);
}
