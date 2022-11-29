import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/downloader/data/datasources/youtube_script.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadImpl implements DownloaderRepo {
  DownloadImpl({
    required this.netChecker,
    required this.downloadData,
  });

  final NetworkChecker netChecker;
  final YoutubeDownloadData downloadData;

  @override
  Future<Either<Failure, double>> downloadObject(
    DownloadInfo info,
    String downloadLocation,
  ) async {
    var storagePermission = await Permission.accessMediaLocation.request();
    // final saf = Saf('~/Downloads');
    // final isGranted = await saf.getDirectoryPermission();
    var fileBytesDownloaded = 0;
    if (storagePermission.isGranted) {
      if (await netChecker.isConnected) {
        var newProgress = 0;

        final streamInfo = await downloadData.getDownloadStream(info);
        final stream = youtube.videos.streamsClient.get(streamInfo);
        final fileName = '${info.itemName}.${info.mediaCodec.split('/').last}';
        final file = File('$downloadLocation/$fileName');
        final fileStream = file.openWrite();

        // Pipe all the content of the stream into the file.
        stream.listen((event) async {
          fileStream.add(event);
          fileBytesDownloaded += event.length;
          newProgress = (fileBytesDownloaded / info.videoSize * 100).floor();
        });

        // Close the file.
        await fileStream.flush();
        await fileStream.close();
        return Right(newProgress.toDouble());
      } else {
        return Left(NetworkFailure());
      }
    } else {
      await Permission.accessMediaLocation.request();
      return Left(DownloadFailure());
    }
  }

  @override
  Future<Either<Failure, List<DownloadInfo>>> getDownloadInfo(
    String url,
    String title,
  ) async {
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
