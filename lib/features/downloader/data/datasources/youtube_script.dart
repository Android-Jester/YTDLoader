import 'dart:math' as math;

import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/downloader/data/models/download_info_model.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubeDownloadData {
  Future<List<DownloadInfoModel>> getDownloadInfo(String url, String title);
  Future<StreamInfo> getDownloadStream(DownloadInfo info);
}

class YoutubeDownloaderData implements YoutubeDownloadData {
  VideoSize sizeType = VideoSize.byte;

  /// Obtains the download info
  @override
  Future<List<DownloadInfoModel>> getDownloadInfo(
      String url, String title,) async {
    final videoManifest = await youtube.videos.streamsClient.getManifest(url);

    final downloadInfo =
        videoManifest.muxed.sortByVideoQuality().map((element) {
      return DownloadInfoModel(
        itemName: title,
        quality: element.qualityLabel,
        mediaCodec: element.codec.mimeType,
        videoSize: _getVideoSize(element),
        bitRates: element.bitrate.megaBitsPerSecond.toString(),
        videoId: url,
        sizeType: sizeType,
      );
    }).toList()
          ..addAll(
            videoManifest.audio
                .sortByBitrate()
                .map(
                  (e) => DownloadInfoModel(
                    itemName: title,
                    quality: e.qualityLabel,
                    mediaCodec: e.codec.mimeType,
                    videoSize: _getVideoSize(e),
                    bitRates: e.bitrate.megaBitsPerSecond.toString(),
                    videoId: url,
                    sizeType: sizeType,
                  ),
                )
                .toList(),
          );
    return downloadInfo;
  }

  double _getVideoSize(StreamInfo element) {
    final size = element.size.totalBytes.toDouble();
    late double muxSize;
    final mb = math.pow(1024, 2);
    final gb = math.pow(1024, 3);

    if (size > gb) {
      muxSize = element.size.totalGigaBytes;
      sizeType = VideoSize.giga;
    } else if (size < gb && size > mb) {
      muxSize = element.size.totalMegaBytes;
      sizeType = VideoSize.mega;
    } else {
      muxSize = element.size.totalKiloBytes;
      sizeType = VideoSize.kilo;
    }

    return muxSize;
  }

  @override
  Future<StreamInfo> getDownloadStream(DownloadInfo info) async {
    final manifest =
        await youtube.videos.streamsClient.getManifest(info.videoId);
    final audio = manifest.audio
        .sortByBitrate()
        .where((element) => element.qualityLabel == info.quality)
        .first;
    final video = manifest.muxed
        .sortByVideoQuality()
        .where((element) => element.qualityLabel == info.quality)
        .first;
    final isMusic = info.mediaCodec.split('/').first != 'video';
    final streamInfo = isMusic ? audio : video;
    return streamInfo;
  }
}
