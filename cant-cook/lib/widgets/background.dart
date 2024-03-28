import 'package:cantcook/utils/colours.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.widget,
    this.appBar,
  }) : super(key: key);
  final Widget widget;
  final AppBar? appBar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: backgroundColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: widget,
              ),
              Positioned(
                left: 0,
                child: Image.asset(
                  width: 120,
                  'assets/images/backgroundCircles.png',
                ),
              ),
            ],
          )),
    );
  }
}
