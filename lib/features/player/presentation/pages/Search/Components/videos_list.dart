import 'package:down_yt/features/downloader/presentation/bloc/downloader_bloc.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:down_yt/features/player/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:pod_player/pod_player.dart';

class VideoList extends StatefulWidget {
  const VideoList({
    required this.info,
    super.key,
  });
  final List<SearchInfo> info;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late PlayerBloc playBloc;
  @override
  void initState() {
    playBloc = BlocProvider.of<PlayerBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.info.length,
      itemBuilder: (ctx, index) {
        final data = widget.info[index];
        return VideoCard(
          channelId: data.channelId,
          imageUrl: data.imageUrl,
          channelName: data.channelName,
          videoLength: data.length.toString(),
          videoTitle: data.title,
          actionOnLongTap: () {},
          actionOnTap: () async {
            final playerFunc = ctx.read<PlayerBloc>();
            playBloc
              ..miniController.animateToHeight(state: PanelState.MAX)
              ..podController = PodPlayerController(
                playVideoFrom: PlayVideoFrom.youtube(
                  data.itemUrl,
                  live: data.isLive,
                  videoPlayerOptions: VideoPlayerOptions(
                    allowBackgroundPlayback: true,
                  ),
                ),
              )
              ..info = data;

            if (playBloc.podController.isInitialised) {
              playerFunc.add(ChangeVideo(bloc: playBloc));
            } else {
              playerFunc.add(PlayVideo(bloc: playBloc));
            }

            ctx.read<DownloaderBloc>().add(
                  GetDownloadItemInfo(
                    title: data.title,
                    videoId: data.itemUrl.split('=').last,
                  ),
                );
          },
        );
      },
    );
  }
}
