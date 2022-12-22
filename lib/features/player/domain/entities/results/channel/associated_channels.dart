part of 'channel_data.dart';

class AssociatedChannel extends Equatable {
  const AssociatedChannel({
    required this.channelIcon,
    required this.channelName,
    required this.channelUrl,
  });

  final String channelIcon;
  final String channelName;
  final String channelUrl;

  @override
  List<Object?> get props => [
        channelIcon,
        channelName,
        channelUrl,
      ];
}
