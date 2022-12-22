import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/downloader/data/models/download_info_model.dart';
import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
import 'package:down_yt/features/player/domain/entities/results/video/video_data.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubeDownloadData {
  Future<List<DownloadInfoModel>> getDownloadModel(VideoData videoData);
  Future<String> getVideoStream();
  Future<String> getAudioStream();
}

class DownloadVideoImpl implements YoutubeDownloadData {
  @override
  Future<List<DownloadInfoModel>> getDownloadModel(VideoData videoData) async {
    try {
      final manifest = await youtube.videos.streams.getManifest(videoData.videoId);
      final streams = manifest.streams;
      final downloadInfoList = <DownloadInfoModel>[];
      for (final item in streams) {
        if (item is AudioOnlyStreamInfo) {
          downloadInfoList.add(
            DownloadInfoModel(
              audioDownloadInfo: AudioDownloadInfo(
                itemName: videoData.title,
                videoQuality: item.qualityLabel,
                mediaCodec: item.codec.mimeType,
                videoId: videoData.videoId,
                stream: item,
                videoSize: item.size.totalBytes,
              ),
            ),
          );
        } else if (item is VideoOnlyStreamInfo) {
          downloadInfoList.add(DownloadInfoModel(
              videoDownloadInfo: VideoDownloadInfo(
            itemName: videoData.title,
            videoQuality: item.qualityLabel,
            mediaCodec: item.codec.mimeType,
            videoId: videoData.videoId,
            stream: item,
            videoSize: item.size.totalBytes,
          )));
        }
      }
      return downloadInfoList;
    } catch (err) {
      //TODO: Exception
      throw Exception();
    }
  }

  @override
  Future<String> getAudioStream(AudioOnlyStreamInfo streamInfo) {
    try {
      final
    } catch(err) {}
  }


  @override
  Future<String> getVideoStream() {
    // TODO: implement getVideoStream
    throw UnimplementedError();
  }
}
