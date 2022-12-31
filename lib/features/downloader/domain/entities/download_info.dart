import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'audio_info.dart';
part 'video_info.dart';

class DownloadInfo extends Equatable {
  const DownloadInfo({
    this.videoDownloadInfo,
    this.audioDownloadInfo,
  });

  final VideoDownloadInfo? videoDownloadInfo;
  final AudioDownloadInfo? audioDownloadInfo;

  @override
  List<Object?> get props => [
        videoDownloadInfo,
        audioDownloadInfo,
      ];
}

class DownloadResult extends Equatable {
  const DownloadResult({
    required this.videoPath,
    required this.audioPath,
  });

  final String videoPath;
  final String audioPath;
  @override
  List<Object?> get props => [
        videoPath,
        audioPath,
      ];
}
