import 'package:equatable/equatable.dart';

class DownloadInfo extends Equatable {
  const DownloadInfo({
    required this.itemName,
    required this.quality,
    required this.mediaCodec,
    required this.videoSize,
    required this.bitRates,
    required this.videoId,
  });

  // Mixed
  final String itemName;
  final String quality;
  final String mediaCodec;
  final String videoId;

  // Video
  final double videoSize;

  // Audio
  final String bitRates;

  @override
  List<Object?> get props => [];
}
