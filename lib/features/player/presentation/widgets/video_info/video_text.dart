
import 'package:flutter/material.dart';

class VideoText extends StatelessWidget {
  const VideoText({
    super.key,
    required this.videoTitle,
    required this.channelName,
    this.fontSize = '15:12',
  });
  final String fontSize;
  final String videoTitle;
  final String channelName;
  @override
  Widget build(BuildContext context) {
    final largeFont = double.parse(fontSize.split(':').first);
    final smallFont = double.parse(fontSize.split(':').last);
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: (largeFont <= 13) ? MediaQuery.of(context).size.width - 150 : MediaQuery.of(context).size.width - 80,
            child: Text(
              videoTitle,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: largeFont,
                  ),
            ),
          ),
          Text(
            channelName,
            softWrap: true,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: smallFont,
                ),
          ),
        ],
      ),
    );
  }
}
