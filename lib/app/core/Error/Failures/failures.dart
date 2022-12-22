import 'package:equatable/equatable.dart';

part 'local_failures.dart';
part 'server_failures.dart';

class Failure extends Equatable {
  const Failure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.errorMessage);
}
