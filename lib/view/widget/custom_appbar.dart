import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;
  final bool hasBack;

  const CustomAppBar({Key? key, required this.hasBack, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: hasBack ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          hasBack
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: BackButton(
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          Center(
            child: Text(
              title,
              style:
                  const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.shade900],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
