import 'package:flutter/material.dart';

import '../usecase/network/network_change.dart';

typedef _R = NetWorkResult;
typedef _Cr = CrossFadeState;

class NetworkWidget extends StatefulWidget {
  const NetworkWidget(this.meneger, {super.key});

  final NetworkMeneger meneger;

  @override
  State<NetworkWidget> createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  _R? result;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  void _init() async {
    result = await widget.meneger.check().whenComplete(() {
      widget.meneger.onChanged(
        (val) => setState(() {
          result = val;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: NetWorkStateWidget(result ?? _R.on),
      secondChild: NetWorkStateWidget(result ?? _R.off),
      duration: const Duration(milliseconds: 300),
      crossFadeState: _state(),
    );
  }

  _Cr _state() => result == _R.on ? _Cr.showFirst : _Cr.showSecond;
}

class NetWorkStateWidget extends StatelessWidget {
  const NetWorkStateWidget(this._res, {super.key});

  final _R _res;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _res == _R.on ? Colors.green : Colors.red,
      child: Center(
        child: Text(
          _res == _R.on ? 'yes connected' : 'no connected',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
