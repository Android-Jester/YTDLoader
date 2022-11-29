import 'dart:async';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/usecases/download_object.dart';
import 'package:down_yt/features/downloader/domain/usecases/get_download_info.dart';
import 'package:equatable/equatable.dart';

part 'downloader_event.dart';
part 'downloader_state.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  DownloaderBloc({
    required this.downInfo,
    required this.downloadObject,
  }) : super(LoadingDownloadInfo()) {
    on<GetDownloadItemInfo>(_downloadInfo);
    on<DownloadItem>(_downloadItem);
  }
  final GetDownloadInfo downInfo;
  final DownloadObject downloadObject;

  FutureOr<void> _downloadInfo(
    GetDownloadItemInfo event,
    Emitter<DownloaderState> emit,
  ) async {
    emit(LoadingDownloadInfo());
    (await downInfo(
      params: DownloadParams(videoId: event.videoId, title: event.title),
    ))
        .fold(
      (l) => emit(InfoCollectFailure(l.errorMessage)),
      (r) {
        final itemList = <DownloadInfo>[
          ...r.where((element) => element.mediaCodec.contains('videos')),
          ...r.where((element) => element.mediaCodec.contains('audio')),
        ];
        emit(DownloadInfoDataGet(itemList));
      },
    );
  }

  FutureOr<void> _downloadItem(
    DownloadItem event,
    Emitter<DownloaderState> emit,
  ) async {
    // final directory = await path.getApplicationDocumentsDirectory();
    final path = await AndroidPathProvider.downloadsPath;
    final data = await downloadObject.call(
      params: ObjectInfo(info: event.info, downloadLocation: path),
    );
    data.fold(
        (l) => emit(DownloadingError(l.errorMessage)), DownloadingItems.new,);
  }
}
