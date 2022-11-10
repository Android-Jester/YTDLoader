import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/downloader/data/models/download_info_model.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubeDownloadData {
  Future<List<DownloadInfoModel>> getDownloadInfo(String url, String title);
  Future<StreamInfo> getDownloadStream(DownloadInfo info);
}

class YoutubeDownloaderData implements YoutubeDownloadData {
  @override
  Future<List<DownloadInfoModel>> getDownloadInfo(String url, String title) async {
    final videoManifest = await youtube.videos.streamsClient.getManifest(url);

    final downloadInfo = videoManifest.muxed.sortByVideoQuality().map((element) {
      return DownloadInfoModel(
        itemName: title,
        quality: element.qualityLabel,
        mediaCodec: element.codec.mimeType,
        videoSize: _getVideoSize(element),
        bitRates: element.bitrate.megaBitsPerSecond.toString(),
        videoId: url,
      );
    }).toList();
    return downloadInfo;
  }

  double _getVideoSize(MuxedStreamInfo element) {
    var sizeType = VideoSize.byte;
    final size = element.size.totalBytes.toDouble();
    late double muxSize;
    const mb = 1024 * 1024;
    const kb = 1024;

    if (size > kb) {
      muxSize = element.size.totalKiloBytes;
      sizeType = VideoSize.kilo;
    } else if (size > mb) {
      muxSize = element.size.totalMegaBytes;
      sizeType = VideoSize.mega;
    } else {
      muxSize = element.size.totalGigaBytes;
      sizeType = VideoSize.giga;
    }
    return muxSize;
  }

  @override
  Future<StreamInfo> getDownloadStream(DownloadInfo info) async {
    final manifest = await youtube.videos.streamsClient.getManifest(info.videoId);
    final audio = manifest.audio.sortByBitrate().where((element) => element.qualityLabel == info.quality).first;
    final video = manifest.muxed.sortByVideoQuality().where((element) => element.qualityLabel == info.quality).first;
    final isMusic = info.mediaCodec.split('/').first != 'video';
    final streamInfo = isMusic ? audio : video;
    return streamInfo;
  }
}
