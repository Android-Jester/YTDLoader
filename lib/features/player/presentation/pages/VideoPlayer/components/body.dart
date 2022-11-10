import 'package:down_yt/features/downloader/presentation/widgets/downloading_popup.dart';
import 'package:down_yt/features/player/presentation/widgets/video_play_display.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.id,
    required this.isLive,
    required this.title,
    required this.author,
    required this.description,
    required this.channelImageUrl,
  });
  final String id;
  final String title;
  final String author;
  final String description;
  final bool isLive;
  final String channelImageUrl;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late YoutubePlayerController _playController;
  @override
  void initState() {
    super.initState();
    _playController = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        isLive: widget.isLive,
      ),
    );
  }

  @override
  void dispose() {
    _playController.dispose();
    super.dispose();
    _playController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _playController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {},
      ),
      builder: (BuildContext ctx, Widget ply) {
        return Column(
          children: [
            ply,
            VideoInfoWidget(
              channelImageUrl: widget.channelImageUrl,
              channelName: widget.author,
              videoTitle: widget.title,
              description: widget.description,
            ),
            DownloadInfoList(
              title: widget.title,
              videoId: widget.id,
            )
          ],
        );
      },
    );
  }
}
