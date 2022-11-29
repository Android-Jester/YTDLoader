part of 'exceptions.dart';

class VideoSearchException implements Exceptions {
  VideoSearchException({required this.message});
  final String message;

  @override
  String get errormessage => message;
}

class VideoStreamException implements Exceptions {
  VideoStreamException({required this.message});
  final String message;

  @override
  String get errormessage => message;
}
