import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/downloader/data/datasources/youtube_script.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';

class DownloadImpl implements DownloaderRepo {
  DownloadImpl({
    required this.netChecker,
    required this.downloadData,
  });

  final NetworkChecker netChecker;
  final YoutubeDownloadData downloadData;

  @override
  Future<double> downloadObject(DownloadInfo info, String downloadLocation) async {
    var progress = 0.0;

    final streamInfo = await downloadData.getDownloadStream(info);
    final stream = youtube.videos.streamsClient.get(streamInfo);

    final file = File("downloadLocation/${info.itemName}.${info.mediaCodec.split('/').last}");
    if (file.existsSync()) {
      file.deleteSync();
    }
    final fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
    var count = 0;
    await for (final data in stream) {
      // Keep track of the current downloaded data.
      count += data.length;
      // Calculate the current progress.
      progress = count / info.videoSize;

      // Write to file.
      fileStream.add(data);
      return progress;
    }
    await fileStream.close();
    return progress;
  }

  @override
  Future<Either<Failure, List<DownloadInfo>>> getDownloadInfo(String url, String title) async {
    try {
      if (await netChecker.isConnected) {
        final model = await downloadData.getDownloadInfo(url, title);
        return Right(model);
      } else {
        return Left(DownloadInfoFailure());
      }
    } catch (e) {
      return Left(DownloadInfoFailure());
    }
  }
}
