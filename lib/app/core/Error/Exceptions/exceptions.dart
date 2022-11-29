part 'local_exceptions.dart';
part 'server_exceptions.dart';

abstract class Exceptions implements Exception {
  Exceptions(this.errormessage);

  final String errormessage;
}
