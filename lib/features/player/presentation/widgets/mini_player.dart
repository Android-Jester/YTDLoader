import 'package:down_yt/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:down_yt/features/player/presentation/widgets/video_info/video_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

import '../pages/VideoPlayer/video_player.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (ctx, state) {
        if (state is PlayerStatus) {
          return Visibility(
            visible: state.isAlive,
            child: Miniplayer(
              controller: state.bloc.miniController,
              minHeight: 90,
              maxHeight: MediaQuery.of(context).size.height,
              builder: (height, percentage) {
                if (percentage < 0.2) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: VideoText(
                          videoTitle: state.bloc.info.title,
                          channelName: state.bloc.info.channelName,
                          fontSize: '10:8',
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ctx
                              .read<PlayerBloc>()
                              .add(StopVideo(bloc: state.bloc));
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  );
                } else {
                  return VideoPlayer(
                    description: state.bloc.info.description,
                    channelId: state.bloc.info.channelId,
                  );
                }
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
