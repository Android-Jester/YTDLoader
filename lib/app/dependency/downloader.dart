part of 'injector.dart';

Future<void> downloaderInject() async {
  locator
    // Bloc
    ..registerFactory(() => DownloaderBloc(downInfo: locator.get<GetDownloadInfo>(), downloadObject: locator.get<DownloadObject>()))
    // Data Source
    ..registerSingleton<YoutubeDownloadData>(YoutubeDownloaderData())
    // Repository
    ..registerSingleton<DownloaderRepo>(
      DownloadImpl(
        netChecker: locator.get<NetworkChecker>(),
        downloadData: locator.get<YoutubeDownloadData>(),
      ),
    )
    // Use case
    ..registerSingleton<GetDownloadInfo>(GetDownloadInfo(repo: locator.get<DownloaderRepo>()))
    ..registerSingleton<DownloadObject>(DownloadObject(locator.get<DownloaderRepo>()));
}
