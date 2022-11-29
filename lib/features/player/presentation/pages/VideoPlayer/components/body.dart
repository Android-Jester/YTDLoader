part of '../video_player.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.isLive,
    required this.description,
    required this.channelId,
  });
  final String channelId;
  final String description;
  final bool isLive;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  late PlayerBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<PlayerBloc>(context);
    bloc.podController.initialise();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void updateKeepAlive() {
    super.updateKeepAlive();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PIPView(
      floatingHeight: 100,
      floatingWidth: 150,
      builder: (context, isFloating) {
        return Column(
          children: [
            bloc.podPlayer,
              Expanded(
                      child: DownloadInfoList(
                        title: bloc.info.title,
                        videoId: bloc.info.videoUrl.split('=').last,
                      ),
              ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
