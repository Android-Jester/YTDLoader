import 'package:youtube_explode_dart/youtube_explode_dart.dart';

YoutubeExplode youtube = YoutubeExplode();
const CHANNEL_ID = 'down_yt';

enum VideoFilter {
  video,
  playList,
  channel,
}

enum VideoSize {
  giga,
  mega,
  kilo,
  byte,
}
