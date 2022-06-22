import 'package:flutter/material.dart';
import 'package:use_case_flutter/core/network_widget.dart';
import 'package:use_case_flutter/usecase/usecase.dart';

import '../home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._meneger, {super.key});

  final NetworkMeneger _meneger;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child!),
            NetworkWidget(_meneger),
          ],
        );
      },
      home: const HomeView(),
    );
  }
}
