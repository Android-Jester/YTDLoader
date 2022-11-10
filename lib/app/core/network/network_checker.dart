import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkChecker {
  Future<bool> get isConnected;
}

class InternetStatus implements NetworkChecker {
  InternetStatus(this.connectionChecker);
  final InternetConnectionChecker connectionChecker;
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
