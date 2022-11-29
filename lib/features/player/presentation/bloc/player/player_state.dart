part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerInitial implements PlayerState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class PlayerStatus implements PlayerState {
  PlayerStatus({required this.bloc, this.isAlive = true}) {
    bloc.podPlayer = PodVideoPlayer(controller: bloc.podController);
    if (isAlive) {
      bloc.miniController.animateToHeight(state: PanelState.MAX);
    } else {
      bloc.podController.pause();
      bloc.podController.dispose();
    }
  }
  final PlayerBloc bloc;
  final bool isAlive;

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
