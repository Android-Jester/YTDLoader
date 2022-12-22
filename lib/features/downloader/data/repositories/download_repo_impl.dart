import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/downloader/data/datasources/youtube_script.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';

class VideoAudioDownloadImpl implements VideoDownloaderRepo {
  VideoAudioDownloadImpl({
    required this.downloadData,
    required this.networkChecker,
  });

  final YoutubeDownloadData downloadData;
  final NetworkChecker networkChecker;
  @override
  Future<Either<Failure, void>> downloadAudio() {
    // TODO: implement downloadAudio
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> downloadPlaylist() {
    // TODO: implement downloadPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> downloadVideo() {
    // TODO: implement downloadVideo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> getDownloadInformation() {
    // TODO: implement getDownloadInformation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> muxVideoAudio() {
    // TODO: implement muxVideoAudio
    throw UnimplementedError();
  }
}
