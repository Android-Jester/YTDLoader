import 'package:flutter/material.dart';

class VideoImage extends StatelessWidget {
  const VideoImage({super.key, required this.imageUrl, required this.isLive, required this.videoLength});

  final String imageUrl;
  final bool isLive;
  final String videoLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isLive ? Colors.red : Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Text(isLive ? 'LIVE' : videoLength.trimRight().split('.').first),
          ),
        ),
      ),
    );
  }
}
