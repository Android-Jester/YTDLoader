import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';

abstract class VideoDownloaderRepo {
  Future<Either<Failure, List<DownloadInfo>>> getDownloadInformation();
  Future<Either<Failure, void>> downloadVideo(DownloadInfo info, String downloadPath);
  Future<Either<Failure, String>> downloadAudio(DownloadInfo info, String downloadPath);
  Future<Either<Failure, void>> muxVideoAudio(DownloadResult result);
  Future<Either<Failure, void>> downloadPlaylist({int start = 0, int end = 0});
}
