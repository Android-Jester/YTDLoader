import 'package:equatable/equatable.dart';

part 'local_failures.dart';
part 'server_failures.dart';

abstract class Failure extends Equatable {
  const Failure(this.errorMessage);

  final String errorMessage;
}

class NetworkFailure implements Failure {
  @override
  String get errorMessage => 'Unable to connect to the internet';

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => false;
}
