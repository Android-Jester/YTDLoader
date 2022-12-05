import 'package:down_yt/app/core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadInfo extends Equatable {
  const DownloadInfo({
    required this.itemName,
    required this.quality,
    required this.mediaCodec,
    required this.videoSize,
    required this.bitRates,
    required this.videoId,
    required this.sizeType,
    required this.stream,
  });

  // Mixed
  final String itemName;
  final String quality;
  final String mediaCodec;
  final String videoId;
  final StreamInfo stream;

  // Video
  final double videoSize;

  // Audio
  final String bitRates;

  // VideoType
  final VideoSize sizeType;

  @override
  List<Object?> get props => [];
}
