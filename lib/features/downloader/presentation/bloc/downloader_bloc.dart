import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/usecases/get_download_info.dart';
import 'package:equatable/equatable.dart';

part 'downloader_event.dart';
part 'downloader_state.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  DownloaderBloc({required this.downInfo}) : super(LoadingDownloadInfo()) {
    on<GetDownloadItemInfo>(_downloadInfo);
  }
  final GetDownloadInfo downInfo;

  FutureOr<void> _downloadInfo(GetDownloadItemInfo event, Emitter<DownloaderState> emit) async {
    emit(LoadingDownloadInfo());
    (await downInfo(params: DownloadParams(videoId: event.videoId, title: event.title))).fold(
      (l) => emit(InfoCollectFailure(l.errorMessage)),
      (r) => emit(DownloadInfoDataGet(r)),
    );
  }
}
