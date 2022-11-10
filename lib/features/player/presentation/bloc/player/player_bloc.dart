import 'package:bloc/bloc.dart';
import 'package:down_yt/features/player/domain/usecases/get_comments.dart';
import 'package:down_yt/features/player/domain/usecases/get_video_data.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required this.videoData,
    required this.comments,
  }) : super(PlayerInitial()) {
    // on<SearchingVideos>(getSearchResult);
  }
  final GetVideoData videoData;
  final GetVideoComments comments;
}
