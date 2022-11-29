import 'package:down_yt/features/player/data/datasources/remote/woker_isolate.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubePlayerData {
  Future<List<VideoSearchModel>> searchVideos(
    String query,
    SearchFilter filter,
  );
}

class YoutubePlayerDataImpl implements YoutubePlayerData {
  final worker = WorkerIsolate();

  @override
  Future<List<VideoSearchModel>> searchVideos(String query, SearchFilter filter) async {
    final data = worker.getVideoSearchList(query, filter);
    worker.dispose();
    return data;
  }
}
