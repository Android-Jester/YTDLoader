import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/downloader/data/datasources/youtube_script.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class VideoAudioDownloadImpl implements VideoDownloaderRepo {
  VideoAudioDownloadImpl({
    required this.downloadData,
    required this.networkChecker,
    required this.dio,
  });

  final YoutubeDownloadData downloadData;
  final NetworkChecker networkChecker;
  final Dio dio;

  @override
  Future<Either<Failure, String>> downloadAudio(DownloadInfo info, String downloadPath) async {
    if (await networkChecker.isConnected) {
      final response = await dio.download(
        (info.audioDownloadInfo?.stream.url.path)!,
        downloadPath,
        // options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (int received, int total) {
          print('Received: $received\nTotal: $total');
        },
      );
      if (response.data != null && response.statusCode == 200) {
        print('Response: ${response.data}');
        return Right(response.data as String);
      } else {
        return const Left(DownloadFailure('Download failure'));
      }
    } else {
      return const Left(DownloadFailure('Download failure'));
    }
  }

  @override
  Future<Either<Failure, void>> downloadVideo(DownloadInfo info, String downloadPath) async {
    try {
      if (await networkChecker.isConnected) {
        final response = await dio.download(
          (info.videoDownloadInfo?.stream.url.path)!,
          downloadPath,
          // options: Options(responseType: ResponseType.bytes),
          onReceiveProgress: (int received, int total) {
            print('Received: $received\nTotal: $total');
          },
        );
        if (response.data != null && response.statusCode == 200) {
          print('Response: ${response.data}');
          return Right(response.data as String);
        } else {
          return const Left(DownloadFailure('Failed to download info'));
        }
      } else {
        return const Left(DownloadFailure('No network'));
      }
    } catch (err) {
      print('err: ${err.toString()}');
      return const Left(DownloadFailure('errorMessage'));
    }
  }

  @override
  Future<Either<Failure, List<DownloadInfo>>> getDownloadInformation() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> muxVideoAudio(DownloadResult result) async {
    try {
      final data = await FFmpegKit.execute('-i ${result.videoPath} -i ${result.audioPath} -c copy output.mp4');
      print(await data.getAllStatistics());
      return const Right(null);
    } catch (err) {
      return const Left(MuxVideoFailure('Failed to Mux Video'));
    }
  }

  @override
  Future<Either<Failure, void>> downloadPlaylist({int start = 0, int end = 0}) {
    // TODO: implement downloadPlaylist
    throw UnimplementedError();
  }
}
