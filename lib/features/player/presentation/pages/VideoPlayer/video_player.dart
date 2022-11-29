import 'package:down_yt/features/downloader/presentation/widgets/downloading_popup.dart';
import 'package:down_yt/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pip_view/pip_view.dart';

part './components/body.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({
    super.key,
    required this.description,
    required this.channelId,
    this.isLive = false,
  });

  final String description;
  final String channelId;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        channelId: channelId,
        description: description,
        isLive: isLive,
      ),
    );
  }
}
