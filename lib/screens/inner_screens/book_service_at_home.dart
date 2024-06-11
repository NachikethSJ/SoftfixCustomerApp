import 'package:flutter/material.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';
class BookServiceHome extends StatefulWidget {
  const BookServiceHome({super.key});

  @override
  State<BookServiceHome> createState() => _BookServiceHomeState();
}

class _BookServiceHomeState extends State<BookServiceHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                ),
                child: Center(child: appText(title: "Include more service",fontSize: 16)),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 2),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset('assets/images/placeholder.png',
                                        width: 90,
                                        height: 90,),
                                      Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 18,right: 18,top: 2,bottom: 2),
                                            child: Text("50% off"),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Column(
                                    children: [
                                      const Text("Madhav Jha"),
                                      Row(
                                        children: [
                                          Image.asset('assets/images/time_icon1.png',height: 20,width: 20,),
                                          const SizedBox(width: 2,),
                                          const Text("2km 10-15min"),
                                        ],
                                      ),
                                      const Text("Service Price: 2500"),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  const Column(
                                    children: [
                                      Text("Hair Cut",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                      Text("2500",style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),),

                                    ],
                                  )
                                ],
                              ),
                              Align(
                                  alignment:Alignment.topRight,
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: appColors.appColor,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                                        child: Text("Book"),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
