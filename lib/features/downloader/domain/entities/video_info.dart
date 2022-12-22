part of 'download_info.dart';

class VideoDownloadInfo extends Equatable {
  const VideoDownloadInfo({
    required this.itemName,
    required this.videoQuality,
    required this.mediaCodec,
    required this.videoId,
    required this.stream,
    required this.videoSize,
  });

  final String itemName;
  final String videoQuality;
  final String mediaCodec;
  final int videoSize;
  final String videoId;
  final VideoOnlyStreamInfo stream;
  @override
  List<Object?> get props => [
        itemName,
        videoQuality,
        mediaCodec,
        videoId,
        stream,
      ];
}
