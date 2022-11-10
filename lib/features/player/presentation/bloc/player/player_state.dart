part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}



class StartPlayer extends PlayerState {}

class StopPlayer extends PlayerState {}

class PausePlayer extends PlayerState {}

class PlayerInitial extends PlayerState {}
