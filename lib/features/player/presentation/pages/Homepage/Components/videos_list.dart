import 'package:down_yt/features/downloader/presentation/bloc/downloader_bloc.dart';
import 'package:down_yt/features/player/domain/entities/video_info.dart';
import 'package:down_yt/features/player/presentation/pages/VideoPlayer/video_player.dart';
import 'package:down_yt/features/player/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoList extends StatelessWidget {
  const VideoList({
    required this.info,
    super.key,
  });
  final List<VideoInfo> info;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: info.length,
      itemBuilder: (ctx, index) {
        final data = info[index];
        return VideoCard(
          imageUrl: data.imageUrl,
          channelName: data.channelName,
          channelImageUrl: data.channelImageUrl,
          videoLength: data.length.toString(),
          videoTitle: data.title,
          actionOnLongTap: () {},
          actionOnTap: () => Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (ctx) {
                ctx.read<DownloaderBloc>().add(
                      GetDownloadItemInfo(
                        title: data.title,
                        videoId: data.videoUrl,
                      ),
                    );
                return VideoPlayer(
                  id: data.videoUrl.split('=').last,
                  isLive: data.isLive,
                  description: data.description,
                  author: data.channelName,
                  title: data.title,
                  channelImageUrl: data.channelImageUrl,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
