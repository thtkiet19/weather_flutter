import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/now_models.dart';

class AnimatedImage extends StatefulWidget {
  final WeatherResponse? response;
  AnimatedImage({Key? key, required this.response}) : super(key: key);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.0, 0.08),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Text('${widget.response!.iconUrl}'),
        //Image.network('assets/images/clouds.png'),
        SlideTransition(
          child: Image.asset(
            widget.response!.iconUrl,
            width: 200,
            height: 200,
          ),
          position: _animation,
        ),
      ],
    );
  }
}
