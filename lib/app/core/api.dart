import 'package:youtube_explode_dart/youtube_explode_dart.dart';

YoutubeExplode youtube = YoutubeExplode();
const apiKey = 'AIzaSyD-cX8EpJKa1RWq6EzrxfrHK-K7qSB8kPk';

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
