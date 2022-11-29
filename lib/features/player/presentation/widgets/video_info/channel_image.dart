import 'package:down_yt/app/core/api.dart';
import 'package:flutter/material.dart';

class ChannelImage extends StatelessWidget {
  const ChannelImage({super.key, required this.channelId});

  final String channelId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: youtube.channels.get(channelId),
      builder: (ctx, snap) {
        return CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          foregroundImage: (snap.data?.url != null) ? NetworkImage(snap.data!.logoUrl) : null,
        );
      },
    );
  }
}
