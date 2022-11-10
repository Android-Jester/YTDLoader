import 'package:down_yt/features/downloader/domain/entities/download_info.dart';

class DownloadInfoModel extends DownloadInfo {
  const DownloadInfoModel({
    required super.itemName,
    required super.quality,
    required super.mediaCodec,
    required super.videoSize,
    required super.bitRates,
    required super.videoId,
  });
}
