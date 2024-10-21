import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final StreamController<bool> _connectivityController =
      StreamController<bool>();

  ConnectivityService() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityController.add(result != ConnectivityResult.none);
    });
  }

  Stream<bool> get connectivityStream => _connectivityController.stream;

  Future<bool> checkConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _connectivitySubscription.cancel();
    _connectivityController.close();
  }
}
