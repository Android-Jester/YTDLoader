import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';

abstract class DownloaderRepo {
  Future<Either<Failure, List<DownloadInfo>>> getDownloadInfo(String url, String title);
  Future<Either<Failure, double>> downloadObject(DownloadInfo info, String downloadLocation);
}
