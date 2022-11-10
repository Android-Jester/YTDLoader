import 'package:equatable/equatable.dart';

part 'local_failures.dart';
part 'server_failures.dart';

abstract class Failure extends Equatable {
  const Failure(this.errorMessage);

  final String errorMessage;
}
