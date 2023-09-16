import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton(
      {Key? key, this.padding = 16, this.isDebuggingMode = false})
      : super(key: key);
  final double padding;
  final bool isDebuggingMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Navigator.of(context).canPop() || isDebuggingMode)
          ? IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              tooltip: "Back",
              onPressed: () {
                Get.back(canPop: true);
              },
              splashRadius: 25,
            )
          : null,
    );
  }
}
