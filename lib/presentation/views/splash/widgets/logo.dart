
import 'package:flutter/material.dart';
import 'package:travellers/presentation/resources/assets_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';

class AnimatedLogo extends StatefulWidget  {

  AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(-1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    ));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller, 
          builder: (BuildContext context, Widget? child) { 
            return AnimatedSize(
              duration: const Duration(seconds: 5),
              child: Opacity(
                opacity: _controller.value,
                child: child,
              ),
            );
          },
          child: const SizedBox(
            child: Image(image: AssetImage(ImageAssets.splashLogo)),
          ),
        ),
        SlideTransition(
          position: _animation,
          child: Text(
            "Explore with us...",
            style: StylesManager.splashTextStyle,
          ),
        )
      ],
    );
  }
}