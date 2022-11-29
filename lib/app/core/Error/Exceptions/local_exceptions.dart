part of 'exceptions.dart';

class ConnectionUnsuccessfulException implements Exceptions {
  ConnectionUnsuccessfulException({required this.message});
  final String message;

  @override
  String get errormessage => message;
}
