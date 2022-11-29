part of 'injector.dart';

Future<void> playerInject() async {
  locator
    // Bloc Factory
    ..registerFactory<SearchBloc>(
      () => SearchBloc(
        search: locator.get<SearchVideos>(),
      ),
    )
    ..registerFactory<PlayerBloc>(PlayerBloc.new,)

    // Data Source
    ..registerLazySingleton<YoutubePlayerData>(YoutubePlayerDataImpl.new)
    // Repository
    ..registerSingleton<PlayerRepo>(
      PlayerRepoImpl(
        internetStatus: locator.get<NetworkChecker>(),
        videoData: locator.get<YoutubePlayerData>(),
      ),
    )

    // UseCases
    // ..registerSingleton<GetVideoData>(
    //   GetVideoData(
    //     locator.get<PlayerRepo>(),
    //   ),
    // )
    // ..registerSingleton<GetVideoComments>(
    //   GetVideoComments(
    //     locator.get<PlayerRepo>(),
    //   ),
    // )
    ..registerSingleton<SearchVideos>(
      SearchVideos(
        locator.get<PlayerRepo>(),
      ),
    );
}
