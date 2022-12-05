part of 'exceptions.dart';

class VideoSearchException implements Exceptions {
  VideoSearchException({required this.message});
  final String message;

  @override
  String get errormessage => message;
}

class VideoDownloadException implements Exceptions {
  VideoDownloadException({required this.message});
  final String message;

  @override
  String get errormessage => message;
}
