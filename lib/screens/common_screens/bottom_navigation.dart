import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/screens/inner_screens/dashboard.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/view_models/cart_provider.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';
import '../inner_screens/cart/cart_screen.dart';
import '../inner_screens/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with CacheManager {
  int index = 0;
  double latitude = 0;
  double longitude = 0;

  Future getLatLongitude() async {
    var data = await getLatLng();
    setState(() {
      latitude = double.tryParse(data.first) ?? 0;
      longitude = double.tryParse(data.last) ?? 0;
    });
  }

  _getNearByData() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        getLatLongitude().then((value) {
          var provider = Provider.of<DashboardProvider>(context, listen: false);
          var body = {
            'lat': latitude,
            'lng': longitude,

            'serviceTypeId': "1",
            'minOffer': 1,
            'maxOffer': 100,
            'minPrice': 1,
            'maxPrice': 5000,
            'minDistance': 1,
            'maxDistance': 40,
            'search': '',

            'personType': index == 0
                ? ''
                : index == 1
                ? '0'
                : index == 2
                ? '1'
                : index == 3
                ? '2'
                : '',
          };
          provider.getShopList(
            context: context,
            body: body,
          );
          provider.getServiceList(
            context: context,
            body: body,
          );
          provider.getMembershipList(
            context: context,
            body: body,
          );
          provider.getPackagesList(
            context: context,
            body: body,
          );
        });
      },
    );
  }

  onTapped(int i) {
    setState(() {
      index = i;
    });
    if (i != 4) {
      _getNearByData();
    }
  }

  @override
  void initState() {
    getLatLongitude();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      const Dashboard(personType: ''),
      const Dashboard(personType: '0'),
      const Dashboard(personType: '1'),
      const Dashboard(personType: '2'),
      const CartScreen(),
      const Profile()
    ];
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        backgroundColor: appColors.appWhite,
        currentIndex: index,
        items: _bottomNavigationBarItem(),
        selectedItemColor: appColors.appColor,
        unselectedItemColor: appColors.appBlack,
        selectedLabelStyle: TextStyle(color: appColors.appColor),
        unselectedLabelStyle: TextStyle(color: appColors.appBlack),
        onTap: onTapped,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        iconSize: 22,
      ),
    );
  }

  _bottomNavigationBarItem() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              color: appColors.appColor,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              color: appColors.appBlack,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        label: texts.home,
      ),
      BottomNavigationBarItem(
        activeIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.man,
              color: appColors.appColor,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.man,
              color: appColors.appBlack,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        label: texts.men,
      ),
      BottomNavigationBarItem(
        activeIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.woman,
              color: appColors.appColor,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.woman,
              color: appColors.appBlack,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        label: texts.women,
      ),
      BottomNavigationBarItem(
        activeIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.boy,
              color: appColors.appColor,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.boy,
              color: appColors.appBlack,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        label: texts.kid,
      ),
      BottomNavigationBarItem(
          activeIcon: Consumer<CartProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Badge(
              isLabelVisible:provider.showCartDetails.length>0,
                    label:  Text("${provider.showCartDetails.length}"),
                    backgroundColor: Colors.teal,


                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: appColors.appColor,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              );
            },
          ),
          icon: Badge(
            label: const Text("0"),
            backgroundColor: Colors.teal,
            child: Icon(
              Icons.shopping_cart_outlined,
              color: appColors.appBlack,
            ),
          ),
          label: texts.cart),
      BottomNavigationBarItem(
          activeIcon: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_outlined,
                color: appColors.appColor,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
          icon: Icon(
            Icons.account_circle_outlined,
            color: appColors.appBlack,
          ),
          label: texts.account),
    ];
  }
}
