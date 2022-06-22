import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:use_case_flutter/usecase/network/network_change.dart';

import 'app/meta_app.dart';

void main() {
  final connectivity = Connectivity();
  final meneger = ConnectivityMeneger(connectivity);
  runApp(MyApp(meneger));
}
