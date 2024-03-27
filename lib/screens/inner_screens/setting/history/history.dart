import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';
import '../../../../utils/app_bar.dart';
import '../../../../utils/app_text.dart';
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(
        context,
        bgColor: Colors.white,
        leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back)),
        actions: [
          appText(
            title: "My History",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.account_circle_sharp,
            color: appColors.appColor,
            size: 50,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3,right: 3,top: 5),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: appColors.appColor,width: 1),borderRadius: BorderRadius.circular(15)),
            ),
            const SizedBox(height: 5,),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (BuildContext context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
                    child: SizedBox(
                      height: 270,
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: appColors.appColor,
                          ),
                        ),
                        child:  Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, bottom: 30, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            appText(
                                              title: "Green Trends",
                                              fontSize: 16,
                                              color: Colors.teal.shade500,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            appText(
                                              title: " (Completed)",
                                              fontSize: 12,
                                              color: Colors.orangeAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        appText(
                                            title: "Eye brow",
                                            color: Colors.blueGrey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                        appText(
                                            title: "Eye brow shaping",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        appText(
                                          title: '12:00:00-12:00:00(Sat,Apr,2024)',
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        appText(
                                          title: '₹500',
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        appText(
                                          title:
                                          'Offer:10%',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        appText(
                                          title:'Stylish:Prabhat',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        appText(
                                          title:'4 hrs.5 min.left',
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 10,right: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: appColors.appColor,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: const Center(child: Text("Reshedule",style: TextStyle(fontWeight: FontWeight.bold),)),
                                          ),

                                        ],
                                      )
                                  ),
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color:
                                    Colors.teal.shade800,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.location_on,color: Colors.white,),
                                        appText(
                                          title: "Follow map to visit shop",
                                          fontWeight: FontWeight.w900,
                                          color: appColors.appWhite,
                                          fontSize: 8,
                                        ),
                                        Icon(Icons.directions,color: Colors.white,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
