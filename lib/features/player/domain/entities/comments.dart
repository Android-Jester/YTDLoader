import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  const Comments({
    required this.commenterName,
    required this.comment,
  });

  final String commenterName;
  final String comment;
  @override
  List<Object?> get props => [];
}
