import 'package:down_yt/features/player/presentation/widgets/video_info/channel_image.dart';
import 'package:down_yt/features/player/presentation/widgets/video_info/video_image.dart';
import 'package:down_yt/features/player/presentation/widgets/video_info/video_text.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    required this.channelId,
    required this.imageUrl,
    required this.channelName,
    required this.videoLength,
    required this.videoTitle,
    required this.actionOnLongTap,
    required this.actionOnTap,
    this.isLive = false,
    super.key,
  });
  final String channelName;
  final bool isLive;
  final String channelId;
  final String imageUrl;
  final String videoTitle;
  final String videoLength;
  final void Function() actionOnTap;
  final void Function() actionOnLongTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actionOnTap,
      onLongPress: actionOnLongTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          // padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          child: Column(
            children: [
              VideoImage(
                imageUrl: imageUrl,
                isLive: isLive,
                videoLength: videoLength,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    ChannelImage(
                      channelId: channelId,
                    ),
                    VideoText(
                      channelName: channelName,
                      videoTitle: videoTitle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
