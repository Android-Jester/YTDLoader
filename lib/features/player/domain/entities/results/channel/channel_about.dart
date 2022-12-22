part of 'channel_data.dart';

class AboutChannel extends Equatable {
  const AboutChannel({
    this.description,
    this.joinDate,
    this.sourceCountry,
    this.associatedChannels,
  });

  final String? description;
  final String? joinDate;
  final String? sourceCountry;
  final List<AssociatedChannel?>? associatedChannels;

  @override
  List<Object?> get props => [
        description,
        joinDate,
        sourceCountry,
        associatedChannels,
      ];
}
