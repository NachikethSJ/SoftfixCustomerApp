import 'package:flutter/material.dart';

import '../common_screens/bottom_navigation.dart';
class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/images/done.png',height: 40,width: 40,),),
            Center(child: Text("Slot Book Successfully.")),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
              },
                child: Center(child: Text("Go to Dashboard"))),

          ],
        ),
      ),
    );
  }
}
