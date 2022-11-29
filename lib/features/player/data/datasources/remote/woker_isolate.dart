import 'dart:async';
import 'dart:isolate';

import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class WorkerIsolate {
  WorkerIsolate() {
    _init();
  }

  late SendPort _mainIsolateSendPort;
  late Isolate _secondIsolate;
  final _secondIsolateReady = Completer<void>();

  late Completer<List<VideoSearchModel>> _data;

  Future<List<VideoSearchModel>> getVideoSearchList(String query, SearchFilter filter) async {
    // gets the message from the main isolate and sends it to the spawned isolate
    final data = YoutubeSearchQuery(query: query, filter: filter);
    _mainIsolateSendPort.send(data);
    _data = Completer<List<VideoSearchModel>>();
    // we return the message obtained from the receivingPort as a future
    return _data.future;
  }

  FutureOr<void> _init() async {
    final mainIsolateReceivePort = ReceivePort();
    final mainIsolateErrorPort = ReceivePort();
    mainIsolateReceivePort.listen(_handleMessage);

    _secondIsolate = await Isolate.spawn(
      _getYoutubeData,
      mainIsolateReceivePort.sendPort,
      onError: mainIsolateErrorPort.sendPort,
    );
  }

  FutureOr<void> initSecondary() async {
    final mainIsolateReceivePort = ReceivePort();
    final mainIsolateErrorPort = ReceivePort();
    mainIsolateReceivePort.listen(_handleMessage);

    _secondIsolate = await Isolate.spawn(
      _getYoutubeData,
      mainIsolateReceivePort.sendPort,
      onError: mainIsolateErrorPort.sendPort,
    );
  }

  Future<void> get isReady => _secondIsolateReady.future;

  static void _getYoutubeData(dynamic message) {
    late SendPort returnSendPort;

    final searchModel = <VideoSearchModel>[];

    /// This receive port listens to the message from the main isolate and sends it to
    final listeningReceivePort = ReceivePort()
      ..listen((message) async {
        try {
          if (message is YoutubeSearchQuery) {
            final searchData = await youtube.search.search(message.query, filter: message.filter);
            var isLast = false;
            while (searchData.length < 100) {
              try {
                searchData.addAll((await searchData.nextPage())!);
                print(searchData.length);
              } catch (e) {
                isLast = true;
              }
            }
            for (final video in searchData) {
              print("looping");
              final channel = await youtube.channels.get(video.channelId.value);
              searchModel.add(
                VideoSearchModel(
                  title: video.title,
                  length: (video.isLive && video.duration == null) ? const Duration(seconds: 1) : video.duration!,
                  videoUrl: video.url,
                  imageUrl: video.thumbnails.highResUrl,
                  isLive: video.isLive,
                  description: video.description,
                  channelName: channel.title,
                  channelImage: channel.logoUrl,
                ),
              );
            }
            print("loop finished");
            returnSendPort.send(searchModel);
          }
        } catch (e) {
          throw VideoSearchException(message: 'Exception: ${e.toString()}');
        }
      });

    /// if the message which is the param of the isolate initialized then we can use it as a return port to the main isolate
    if (message is SendPort) {
      returnSendPort = message;

      /// sending the send port of the second isolate's receive port
      // ignore: cascade_invocations
      returnSendPort.send(listeningReceivePort.sendPort);
      return;
    }
  }

  void dispose() {
    print("killing isolate");
    _secondIsolate.kill();
    print("isolate killed");
  }

  void _handleMessage(dynamic secondIsolateMessage) {
    if (secondIsolateMessage is SendPort) {
      _mainIsolateSendPort = secondIsolateMessage;
      _secondIsolateReady.complete();
      return;
    }
    if (secondIsolateMessage is List<VideoSearchModel>) {
      _data.complete(secondIsolateMessage);
    }
  }
}

class YoutubeSearchQuery {
  YoutubeSearchQuery({
    required this.query,
    required this.filter,
  });

  final String query;
  final SearchFilter filter;
}
