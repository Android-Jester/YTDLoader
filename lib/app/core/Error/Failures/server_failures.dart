part of 'failures.dart';

// Downloader Failures
class DownloadFailure extends Failure {
  const DownloadFailure(super.errorMessage);
}

class DownloadInfoFailure extends Failure {
  const DownloadInfoFailure(super.errorMessage);
}

class MuxVideoFailure extends Failure {
  const MuxVideoFailure(super.errorMessage);
}
// Player Failures

class DataFailure extends Failure {
  const DataFailure(super.errorMessage);
}

class SearchFailure extends Failure {
  const SearchFailure(super.errorMessage);
}
