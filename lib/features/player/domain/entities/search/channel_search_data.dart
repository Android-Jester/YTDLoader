part of 'search_data.dart';

class ChannelSearchData extends Equatable {
  const ChannelSearchData({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
    required this.videoCount,
  });

  final String channelId;
  final String channelName;
  final String channelDescription;
  final int videoCount;
  @override
  List<Object?> get props => [
        channelId,
        channelName,
        channelDescription,
        videoCount,
      ];
}
