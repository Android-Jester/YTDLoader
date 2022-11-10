part of 'downloader_bloc.dart';

abstract class DownloaderEvent extends Equatable {
  const DownloaderEvent();

  @override
  List<Object> get props => [];
}

class GetDownloadItemInfo implements DownloaderEvent {
  const GetDownloadItemInfo({
    required this.title,
    required this.videoId,
  });
  final String videoId;
  final String title;

  @override
  List<Object> get props => [title, videoId];

  @override
  bool? get stringify => false;
}
