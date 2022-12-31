// part of 'injector.dart';
//
// Future<void> downloaderInject() async {
//   locator
//     // Bloc
//     ..registerFactory(() => DownloaderBloc(downInfo: locator.get<GetDownloadInfo>(), downloadObject: locator.get<DownloadObject>()))
//     // Data Source
//     ..registerSingleton<YoutubeDownloadData>(YoutubeDownloaderData())
//     // Repository
//     ..registerSingleton<VideoDownloaderRepo>(
//       DownloadImpl(
//         netChecker: locator.get<NetworkChecker>(),
//         downloadData: locator.get<YoutubeDownloadData>(),
//       ),
//     )
//     // Use case
//     ..registerSingleton<GetDownloadInfo>(GetDownloadInfo(repo: locator.get<VideoDownloaderRepo>()))
//     ..registerSingleton<DownloadObject>(DownloadObject(locator.get<VideoDownloaderRepo>()));
// }
