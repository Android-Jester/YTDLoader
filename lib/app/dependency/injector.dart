import 'package:down_yt/app/core/network/network_checker.dart';
import 'package:down_yt/features/downloader/data/datasources/youtube_script.dart';
import 'package:down_yt/features/downloader/data/repositories/download_repo_impl.dart';
import 'package:down_yt/features/downloader/domain/repositories/download_repo.dart';
import 'package:down_yt/features/downloader/domain/usecases/Download_Object.dart';
import 'package:down_yt/features/downloader/domain/usecases/get_download_info.dart';
import 'package:down_yt/features/downloader/presentation/bloc/downloader_bloc.dart';
import 'package:down_yt/features/player/data/datasources/player_data.dart';
import 'package:down_yt/features/player/data/repositories/player_repo_impl.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';
import 'package:down_yt/features/player/domain/usecases/get_comments.dart';
import 'package:down_yt/features/player/domain/usecases/get_video_data.dart';
import 'package:down_yt/features/player/domain/usecases/search_videos.dart';
import 'package:down_yt/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'downloader.dart';
part 'player.dart';

GetIt locator = GetIt.instance;

Future<void> startUp() async {
  locator

      // General Inject
      .registerSingleton<NetworkChecker>(
    InternetStatus(
      InternetConnectionChecker(),
    ),
  );

  // Player Injector
  await playerInject();

  // Downloader Injectory
  await downloaderInject();
}
