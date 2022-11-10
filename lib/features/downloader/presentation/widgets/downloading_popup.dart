import 'package:down_yt/features/downloader/presentation/bloc/downloader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadInfoList extends StatefulWidget {
  const DownloadInfoList({
    required this.title,
    required this.videoId,
    super.key,
  });

  final String title;
  final String videoId;

  @override
  State<DownloadInfoList> createState() => _DownloadInfoListState();
}

class _DownloadInfoListState extends State<DownloadInfoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloaderBloc, DownloaderState>(
      builder: (ctx, state) {
        if (state is DownloadInfoDataGet) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
                itemCount: state.info.length,
                itemBuilder: (ctx, index) {
                  final itemInfo = state.info[index];
                  return ListTile(
                    title: Text(widget.title),
                    subtitle: Text('${itemInfo.mediaCodec}||${itemInfo.quality}'),
                    trailing: Text(itemInfo.videoSize.toString()),
                  );
                }),
          );
        } else if (state is InfoCollectFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
