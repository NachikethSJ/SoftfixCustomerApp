import 'dart:async';

import 'package:flutter/material.dart';

class DynamicPageView extends StatefulWidget {
  final List<String> imagePaths;
  final Color indicatorColor;
  final Color activeIndicatorColor;

  const DynamicPageView({
    Key? key,
    required this.imagePaths,
    this.indicatorColor = Colors.deepOrangeAccent,
    this.activeIndicatorColor = Colors.blue,
  }) : super(key: key);

  @override
  _DynamicPageViewState createState() => _DynamicPageViewState();
}

class _DynamicPageViewState extends State<DynamicPageView> {
  late final PageController _pageController;
  int _activePage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.page == widget.imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 5,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            itemBuilder: (context, index) {
              return ImagePlaceHolder(imagePath: widget.imagePaths[index]);
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(widget.imagePaths.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _activePage == index
                          ? widget.activeIndicatorColor
                          : widget.indicatorColor,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePlaceHolder extends StatelessWidget {
  final String? imagePath;

  const ImagePlaceHolder({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        imagePath!,
        fit: BoxFit.cover,
      ),
    );
  }
}
