// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:down_yt/app/core/Error/Exceptions/exceptions.dart';
// import 'package:down_yt/app/core/api.dart';
// import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
//
// class DownloaderIsolate {
//   DownloaderIsolate() {
//     _init();
//   }
//   late SendPort _mainIsolateSendPort;
//   late Isolate _secondIsolate;
//   final _secondIsolateReady = Completer<void>();
//
//   late Completer<int> _data;
//
//   Future<int> downloadObject(DownloadInputs info) async {
//     // gets the message from the main isolate and sends it to the spawned isolate
//     _mainIsolateSendPort.send(info);
//     _data = Completer<int>();
//     // we return the message obtained from the receivingPort as a future
//     return _data.future;
//   }
//
//   FutureOr<void> _init() async {
//     final mainIsolateReceivePort = ReceivePort();
//     final mainIsolateErrorPort = ReceivePort();
//     mainIsolateReceivePort.listen(_handleMessage);
//
//     _secondIsolate = await Isolate.spawn(
//       _downloadFile,
//       mainIsolateReceivePort.sendPort,
//       onError: mainIsolateErrorPort.sendPort,
//     );
//   }
//
//   FutureOr<void> initSecondary() async {
//     final mainIsolateReceivePort = ReceivePort();
//     final mainIsolateErrorPort = ReceivePort();
//     mainIsolateReceivePort.listen(_handleMessage);
//
//     _secondIsolate = await Isolate.spawn(
//       _downloadFile,
//       mainIsolateReceivePort.sendPort,
//       onError: mainIsolateErrorPort.sendPort,
//     );
//   }
//
//   Future<void> get isReady => _secondIsolateReady.future;
//
//   static void _downloadFile(dynamic message) {
//     late SendPort returnSendPort;
//
//     /// This receive port listens to the message from the main isolate and sends it to
//     final listeningReceivePort = ReceivePort()
//       ..listen((message) async {
//         try {
//           if (message is DownloadInputs) {
//             var fileBytesDownloaded = 0;
//             var newProgress = 0;
//
//             final streamInfo = message.info.stream;
//             final stream = youtube.videos.streamsClient.get(streamInfo);
//             final fileName = '${message.info.itemName}.${message.info.mediaCodec.split('/').last}';
//             final file = File('${message.path}/$fileName');
//             print('File Path: ${file.path}');
//             if (file.existsSync()) {
//               await file.create();
//               print('file Created');
//             }
//             final fileStream = file.openWrite();
//
//             print('stream in progress');
//             // Pipe all the content of the stream into the file.
//             await for (var i in stream) {
//               print('stream: $i');
//               fileStream.add(i);
//               fileBytesDownloaded += i.length;
//               newProgress = (fileBytesDownloaded / message.info.stream.size.totalBytes * 100).floor();
//               print('PROGRESS: $newProgress%');
//             }
//             // stream.listen((event) async {
//             //   print('stream started');
//             //
//             //   fileStream.add(event);
//             //   fileBytesDownloaded += event.length;
//             //   newProgress = (fileBytesDownloaded / message.info.videoSize * 100).floor();
//             //   print('PROGRESS: $newProgress%');
//             // });
//
//             // Close the file.
//             await fileStream.flush();
//             await fileStream.close();
//             returnSendPort.send(newProgress);
//           }
//         } catch (e) {
//           throw VideoDownloadException(message: 'Exception: ${e.toString()}');
//         }
//       });
//
//     /// if the message which is the param of the isolate initialized then we can use it as a return port to the main isolate
//     if (message is SendPort) {
//       returnSendPort = message;
//
//       /// sending the send port of the second isolate's receive port
//       // ignore: cascade_invocations
//       returnSendPort.send(listeningReceivePort.sendPort);
//       return;
//     }
//   }
//
//   static void _downloadPlayList(dynamic message) {
//     late SendPort returnSendPort;
//   }
//
//   void dispose() {
//     print("killing isolate");
//     _secondIsolate.kill();
//     print("isolate killed");
//   }
//
//   void _handleMessage(dynamic secondIsolateMessage) {
//     if (secondIsolateMessage is SendPort) {
//       _mainIsolateSendPort = secondIsolateMessage;
//       _secondIsolateReady.complete();
//       return;
//     }
//     if (secondIsolateMessage is int) {
//       _data.complete(secondIsolateMessage);
//     }
//   }
// }
//
// class DownloadInputs {
//   DownloadInputs(this.path, this.info);
//
//   final String path;
//   final DownloadInfo info;
// }
