import 'dart:async';
import 'dart:isolate';

import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
import 'package:down_yt/app/core/api.dart';
import 'package:down_yt/features/player/data/models/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerWorkerIsolate {
  PlayerWorkerIsolate() {
    _init();
  }
  late SendPort _mainIsolateSendPort;
  late Isolate _secondIsolate;
  final _secondIsolateReady = Completer<void>();

  late Completer<List<SearchModel>> _data;

  Future<List<SearchModel>> getVideoSearchList(String query, SearchFilter filter) async {
    // gets the message from the main isolate and sends it to the spawned isolate
    final data = YoutubeSearchQuery(query: query, filter: filter);
    _mainIsolateSendPort.send(data);
    _data = Completer<List<SearchModel>>();
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

    final searchModel = <SearchModel>[];

    /// This receive port listens to the message from the main isolate and sends it to
    final listeningReceivePort = ReceivePort()
      ..listen((message) async {
        try {
          if (message is YoutubeSearchQuery) {
            final playListSearch = (await youtube.search.searchContent(message.query, filter: message.filter) as SearchList<SearchPlaylist>).map((playlistItem) {
              final playListId = playlistItem.playlistId.value;
              print('playlist');
              return SearchModel(
                itemTitle: playlistItem.playlistTitle,
                itemUrl: 'https://youtube.com/playlist?list=$playListId',
                imageUrl: playlistItem.thumbnails.first.url.path,
                isPlayList: true,
                playlistId: playListId,
                playListLength: playlistItem.playlistVideoCount,
              );
            }).toList();
            final channelSearch = (await youtube.search.searchContent(message.query, filter: message.filter) as SearchList<SearchChannel>).map((channelItem) async {
              final channel = await youtube.channels.get(channelItem.id);
              return SearchModel(
                itemTitle: '',
                itemUrl: channel.url,
                imageUrl: '',
                channelImage: channel.logoUrl,
                channelName: channelItem.name,
                description: channelItem.description,
              );
            }).toList();
            final videoSearch = (await youtube.search.searchContent(message.query, filter: message.filter) as SearchList<SearchVideo>).map((videoItem) async {
              final channel = await youtube.channels.get(videoItem.id);
              final video = await youtube.videos.get(videoItem.id);
              return SearchModel(
                itemTitle: videoItem.title,
                itemUrl: 'https://www.youtube.com/watch?v=${videoItem.id.value}',
                imageUrl: videoItem.thumbnails.where((element) => element.height > 250).first.url.path,
                channelImage: channel.logoUrl,
                channelName: channel.title,
                description: videoItem.description,
                isLive: videoItem.isLive,
                videoLength: video.duration!,
              );
            }).toList();

            final searchData = <SearchModel>[];
            for (final item in videoSearch) {
              searchData.add(await item);
            }
            for (final item in playListSearch) {
              searchData.add(item);
            }
            for (final item in channelSearch) {
              searchData.add(await item);
            }

            print('loop finished');
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
    if (secondIsolateMessage is List<SearchModel>) {
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
