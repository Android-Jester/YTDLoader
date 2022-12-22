import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';

abstract class VideoDownloaderRepo {
  Future<Either<Failure, void>> getDownloadInformation();
  Future<Either<Failure, void>> downloadVideo();
  Future<Either<Failure, void>> downloadAudio();
  Future<Either<Failure, void>> muxVideoAudio();
  Future<Either<Failure, void>> downloadPlaylist({int start = 0, int end = 0});
}
