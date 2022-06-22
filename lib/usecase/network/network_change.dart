import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef NResult = ConnectivityResult;

enum NetWorkResult {
  on,
  off;

  static NetWorkResult check(ConnectivityResult result) {
    if (result == NResult.bluetooth || result == NResult.none) {
      return NetWorkResult.off;
    } else {
      return NetWorkResult.on;
    }
  }
}

abstract class NetworkMeneger {
  Future<NetWorkResult> check();
  void onChanged(void Function(NetWorkResult result) onChage);
  void dispose();
}

class ConnectivityMeneger implements NetworkMeneger {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;

  ConnectivityMeneger(this._connectivity);

  @override
  Future<NetWorkResult> check() async {
    final res = await _connectivity.checkConnectivity();
    return NetWorkResult.check(res);
  }

  @override
  void onChanged(
    void Function(NetWorkResult result) onChage,
  ) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChage(NetWorkResult.check(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
