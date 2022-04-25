import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.deepPurple,
          size: 50.0,
        )
      )
    );
  }
}
