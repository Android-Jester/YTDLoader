import 'package:dartz/dartz.dart';
import 'package:down_yt/app/core/Error/Failures/failures.dart';
import 'package:down_yt/app/core/use_case/activity_usecase.dart';
import 'package:down_yt/features/player/domain/entities/results/channel/channel_data.dart';
import 'package:down_yt/features/player/domain/repositories/player_repo.dart';

class GetChannelData extends ActivityUseCase<ChannelData, String> {
  GetChannelData({
    required this.repository,
  });

  final PlayerRepo repository;
  @override
  Future<Either<Failure, ChannelData>> call({required String params}) {
    return repository.channelInfo(params);
  }
}
