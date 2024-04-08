import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/screens/auth_screens/login.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/help/help.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/history/history.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/memberships/membership.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/my_booking/my_booking.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/package/packge.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/alert.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String number = '';
  getUserData() async {
    var state = AuthProvider(await SharedPreferences.getInstance());
    setState(() {
      number = state.userData.mobile ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  List<Map<String, dynamic>> navigationData = [
    {'icon': Icons.book, 'title': texts.myBooking},
    {'icon': Icons.pattern, 'title': texts.package},
    {'icon': Icons.card_membership, 'title': texts.membership},
    {'icon': Icons.chat_bubble_outline, 'title': texts.history},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: appBar(
        //   context,
        //   bgColor: appColors.appColor,
        //   leading: const SizedBox(),
        //   actions: [
        //     appText(
        //       title: number,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Icon(
        //       Icons.account_circle_sharp,
        //       color: appColors.appBlack,
        //       size: 50,
        //     ),
        //     const SizedBox(
        //       width: 20,
        //     ),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0,left: 2,right: 2,bottom: 0),
            child: Column(
              children: [
                Container(
                  height: 55,
                  decoration: BoxDecoration(color: appColors.appColor,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: appText(
                          title: number,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
      
                      Icon(
                        Icons.personal_injury_sharp,
                        color: appColors.appBlack,
                        size: 40,
                      ),
      
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                   border: Border.all( color: appColors.appColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset(
                                  'assets/images/whatsapp.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: appText(
                              title: texts.shareUs,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: appColors.appGray,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Icon(
                              Icons.content_copy_sharp,
                              color: appColors.appBlack,
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          appText(
                            title: texts.copyLink,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: appColors.appGray,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Divider(
                                color: Colors.grey.shade100,
                              ),
                            );
                          },
                          itemCount: navigationData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _navigationCard(
                              navigationData[index]['icon'],
                              navigationData[index]['title'],
                              index,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            await alert(
                              heading: 'Logout',
                              subTitle: 'Are you sure, Do you want to log out?',
                              acceptTitle: 'Yes',
                              context: context,
                              denyTitle: 'No',
                              height: 210,
                              onPressed: () {
                                _logout();
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: appColors.appGray100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  appText(
                                    title: texts.logout,
                                    fontSize: 16,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: appColors.appBlack,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigationCard(IconData icon, String title,int index,) {
    return InkWell(
      onTap: () {
        if(navigationData[index]['title']== texts.myBooking){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyBooking()));
        }
        else if(navigationData[index]['title']== texts.history){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryPage()));

        }
        else if(navigationData[index]['title']== texts.help){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpPage()));

        }
        else if(navigationData[index]['title']== texts.package){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PackageScreen()));

        }
        else if(navigationData[index]['title']== texts.membership){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MemberShipspage()));

        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 24,
                  child: Icon(
                    icon,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 6,
                  child: appText(
                    title: title,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: appColors.appColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _logout() {
    var provider = Provider.of<AuthProvider>(context, listen: false);
    provider.logOut(context: context).then((value) {
      navigateRemoveUntil(context: context, to: const Login());
    });
  }
}
