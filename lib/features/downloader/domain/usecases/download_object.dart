import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';
import 'package:equatable/equatable.dart';

class DownloadVideo extends ActivityUseCase<void, ObjectInfo> {
  DownloadVideo(this.repo);

  final VideoDownloaderRepo repo;
  @override
  Future<Either<Failure, void>> call({required ObjectInfo params}) async {
    return repo.downloadVideo(
      params.info,
      params.downloadLocation,
    );
  }
}

class ObjectInfo extends Equatable {
  const ObjectInfo({
    required this.info,
    required this.downloadLocation,
  });

  final DownloadInfo info;
  final String downloadLocation;

  @override
  List<Object?> get props => [];
}
