part of 'downloader_bloc.dart';

abstract class DownloaderState extends Equatable {
  const DownloaderState();

  @override
  List<Object> get props => [];
}

class LoadingDownloadInfo extends DownloaderState {}

class InfoCollectFailure extends DownloaderState {
  const InfoCollectFailure(this.errorMessage);

  final String errorMessage;
}

class DownloadInfoDataGet extends DownloaderState {
  const DownloadInfoDataGet(this.info);

  final List<DownloadInfo> info;
}
