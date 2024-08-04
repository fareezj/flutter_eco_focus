import 'package:flutter/material.dart';

class TreeGrowthWidget extends StatefulWidget {
  final int growthLevel;
  const TreeGrowthWidget({super.key, required this.growthLevel});

  @override
  _TreeGrowthWidgetState createState() => _TreeGrowthWidgetState();
}

class _TreeGrowthWidgetState extends State<TreeGrowthWidget>
    with SingleTickerProviderStateMixin {
  bool _showFirstImage = true;
  late AnimationController _controller;
  late Animation<Offset> _animationUp;
  late Animation<Offset> _animationDown;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationUp = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    _animationDown = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    // _toggleImage();
  }

  void _toggleImage() {
    if (_showFirstImage) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  Widget _getImageForGrowthLevel() {
    switch (widget.growthLevel) {
      case 1:
        return Image.asset(
          'assets/images/tree-1.png',
          height: 150.0,
          key: const ValueKey<int>(1),
        );
      case 2:
        return Image.asset(
          'assets/images/tree-2.png',
          height: 150.0,
          key: const ValueKey<int>(2),
        );
      case 3:
        return Image.asset(
          'assets/images/tree-3.png',
          height: 150.0,
          key: const ValueKey<int>(3),
        );
      case 4:
        return Image.asset(
          'assets/images/tree-4.png',
          height: 150.0,
          key: const ValueKey<int>(3),
        );
      case 5:
        return Image.asset(
          'assets/images/tree-5.png',
          height: 150.0,
          key: const ValueKey<int>(3),
        );
      case 6:
        return Image.asset(
          'assets/images/tree-6.png',
          height: 150.0,
          key: const ValueKey<int>(3),
        );
      case 7:
        return Image.asset(
          'assets/images/tree-7.png',
          height: 150.0,
          key: const ValueKey<int>(3),
        );
      default:
        return Image.asset(
          'assets/images/tree-1.png',
          height: 150.0,
          key: const ValueKey<int>(1),
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TreeGrowthWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.growthLevel == 2 && oldWidget.growthLevel != 2) {
      _toggleImage();
    }
    if (widget.growthLevel == 3 && oldWidget.growthLevel != 3) {
      _toggleImage();
    }
    if (widget.growthLevel == 4 && oldWidget.growthLevel != 4) {
      _toggleImage();
    }
    if (widget.growthLevel == 5 && oldWidget.growthLevel != 5) {
      _toggleImage();
    }
    if (widget.growthLevel == 6 && oldWidget.growthLevel != 6) {
      _toggleImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRect(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _showFirstImage ? _animationDown : _animationUp,
                      child: _getImageForGrowthLevel(),
                    );
                  },
                ),
              ),
              Container(
                height: 20.0,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
              ),
              Text(widget.growthLevel.toString())
            ],
          ),
          // const SizedBox(height: 20),
          // ElevatedButton(onPressed: _toggleImage, child: const Text('change'))
        ],
      ),
    );
  }
}
