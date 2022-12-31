// import 'package:down_yt/app/core/api.dart';
// import 'package:down_yt/features/downloader/data/datasources/downloader_isolate.dart';
// import 'package:down_yt/features/downloader/domain/entities/download_info.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
//
// void main() {
//   final downloader = DownloaderIsolate();
//
//   test('downloadObject', () async {
//     await downloader.isReady;
//     final manifest = await youtube.videos.streamsClient.getManifest('tu2tKruJjhY');
//     final info = manifest.muxed
//         .sortByVideoQuality()
//         .map(
//           (e) => DownloadInfo(
//             itemName: 'test',
//             quality: e.qualityLabel,
//             mediaCodec: e.codec.mimeType,
//             videoSize: e.size.totalMegaBytes,
//             bitRates: e.bitrate.gigaBitsPerSecond.toString(),
//             videoId: 'tu2tKruJjhY',
//             sizeType: VideoSize.mega,
//             stream: e,
//           ),
//         )
//         .toList()
//         .first;
//     final docs = await getApplicationDocumentsDirectory();
//     final data = await downloader.downloadObject(DownloadInputs(docs.path, info));
//     expect(data, 100);
//     downloader.dispose();
//   });
// }
