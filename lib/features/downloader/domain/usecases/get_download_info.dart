import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';
import 'package:equatable/equatable.dart';

class GetDownloadInfo extends ActivityUseCase<List<DownloadInfo>, DownloadParams> {
  GetDownloadInfo({
    required this.repo,
  });

  final DownloaderRepo repo;

  @override
  Future<Either<Failure, List<DownloadInfo>>> call({required DownloadParams params}) {
    return repo.getDownloadInfo(params.videoId, params.title);
  }
}

class DownloadParams extends Equatable {
  DownloadParams({
    required this.videoId,
    required this.title,
  });

  final String videoId;
  final String title;
  @override
  List<Object?> get props => [
        videoId,
        title,
      ];
}
