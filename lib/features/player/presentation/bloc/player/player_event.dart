part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {}

class PlayVideo extends PlayerEvent {
  PlayVideo({required this.bloc});

  final PlayerBloc bloc;

  @override
  List<Object?> get props => [bloc];
}

class StopVideo extends PlayerEvent {
  StopVideo({required this.bloc});

  final PlayerBloc bloc;

  @override
  List<Object?> get props => [bloc];
}

class ChangeVideo extends PlayerEvent {
  ChangeVideo({required this.bloc}) {
    bloc.podController.dispose();
    bloc.miniController.animateToHeight(state: PanelState.MIN);
  }
  final PlayerBloc bloc;
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
