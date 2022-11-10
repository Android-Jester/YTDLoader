part of 'failures.dart';

class LocalVideoGetFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String get errorMessage => 'Unable to locate video';
}
