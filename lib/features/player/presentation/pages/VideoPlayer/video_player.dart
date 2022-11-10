import 'package:down_yt/features/player/presentation/pages/VideoPlayer/components/body.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.channelImageUrl,
    this.isLive = false,
  });

  final String id;
  final String title;
  final String author;
  final String description;
  final bool isLive;
  final String channelImageUrl;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: widget.title,
        channelImageUrl: widget.channelImageUrl,
        author: widget.author,
        description: widget.description,
        isLive: widget.isLive,
        id: widget.id,
      ),
    );
  }
}
