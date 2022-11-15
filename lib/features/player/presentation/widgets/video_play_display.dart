import 'package:flutter/material.dart';

class VideoInfoWidget extends StatefulWidget {
  const VideoInfoWidget({
    super.key,
    required this.channelImageUrl,
    required this.videoTitle,
    required this.channelName,
    required this.description,
  });
  final String channelImageUrl;
  final String videoTitle;
  final String channelName;
  final String description;

  @override
  State<VideoInfoWidget> createState() => _VideoInfoWidgetState();
}

class _VideoInfoWidgetState extends State<VideoInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(widget.channelImageUrl),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    widget.videoTitle,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
                Text(
                  widget.channelName,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
