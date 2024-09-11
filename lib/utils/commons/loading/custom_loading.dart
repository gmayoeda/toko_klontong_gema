import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key, this.type = 0});

  final int type;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // icon
      Visibility(visible: widget.type == 1, child: _buildLoadingTwo()),
    ]);
  }

  Widget _buildLoadingTwo() {
    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        'assets/images/logo.png',
        height: 32,
        width: 32,
      ),
      RotationTransition(
        alignment: Alignment.center,
        turns: _controller,
        child: Image.asset(
          'assets/images/loading.png',
          height: 80,
          width: 80,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
