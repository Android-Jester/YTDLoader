import 'dart:async';

import 'package:flutter/foundation.dart';
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

Future<L> mulitFunc<T, L>(L Function(T data) func, T data) async {
  return compute<T, L>((message) => func(data), data);
}
