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
class VideoGetFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String get errorMessage => 'Failed to obtain video stream';
}

class VideoDataGetFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String get errorMessage => 'Failed to acquire Video Data';
}

class VideoSearchFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String get errorMessage => 'Search Failed';
}
