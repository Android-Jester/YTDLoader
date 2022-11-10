import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    required this.imageUrl,
    required this.channelName,
    required this.channelImageUrl,
    required this.videoLength,
    required this.videoTitle,
    required this.actionOnLongTap,
    required this.actionOnTap,
    this.isLive = false,
    super.key,
  });
  final String channelName;
  final String channelImageUrl;
  final bool isLive;
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
          padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isLive ? Colors.red : Colors.blue,
                      ),
                      child: Text(isLive ? 'LIVE' : videoLength.trimRight().split('.').first),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      foregroundImage: NetworkImage(channelImageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              videoTitle,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                          Text(
                            channelName,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    )
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
