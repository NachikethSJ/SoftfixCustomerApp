import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/models/dashboard_models/membership_model.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_shop_model.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/screens/inner_screens/membership_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/sub_service_detail.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../models/dashboard_models/near_by_service_model.dart';

class DynamicPageView extends StatefulWidget {
  final List<String> imagePaths;
  final Color indicatorColor;
  final Color activeIndicatorColor;
  final dynamic lat;
  final dynamic lang;

  const DynamicPageView({
    Key? key,
    required this.imagePaths,
    this.indicatorColor = Colors.deepOrangeAccent,
    this.activeIndicatorColor = Colors.blue,
    required this.lat,
    required this.lang,
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
              return ImagePlaceHolder(
                imagePath: widget.imagePaths[index],
                index: index,
                lang: widget.lang,
                lat: widget.lat,
              );
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
              children:
                  List<Widget>.generate(widget.imagePaths.length, (index) {
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
  final int index;
  final dynamic lat;
  final dynamic lang;

  const ImagePlaceHolder(
      {Key? key, this.imagePath, required this.index, this.lat, this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            _navigation(
              context,
              provider.getLatestDetails[index].type ?? '',
              package: provider.getLatestDetails[index].package,
              membership: provider.getLatestDetails[index].membership,
              service: provider.getLatestDetails[index].service,
              subServiceId: provider.getLatestDetails[index].subServiceId,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  _navigation(BuildContext context, String type,
      {PackagesModel? package,
      MembershipModel? membership,
      NearServiceModel? service,
      dynamic subServiceId}) {
    switch (type) {
      case 'package':
        navigateTo(
            context: context,
            to: PackageDetail(
              data: package!,
              lat: lat,
              lang: lang,
              packageid: package.id,
            ));
        break;
      case 'service':
        navigateTo(
            context: context,
            to: SubServiceDetail(
              lat: lat,
              lng: lang,
              subServiceid: subServiceId.toString(),
            ));
        break;
      case 'membership':
        navigateTo(
            context: context,
            to: MembershipDetail(
              data: membership!,
              lat: lat,
              lang: lang,
              memberid: membership.id,
            ));
        break;
    }
  }
}
