import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_service_model.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';

class SubServiceDetail extends StatefulWidget {
  final SubService data;
  final Shop shopData;
  final double lat;
  final double lng;
  const SubServiceDetail(
      {super.key,
      required this.data,
      required this.shopData,
      required this.lat,
      required this.lng});

  @override
  State<StatefulWidget> createState() => SubServiceDetailState();
}

class SubServiceDetailState extends State<SubServiceDetail> {
  int count = 1;
  bool isbottom = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.data.image?.first ?? '',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: appText(
                      title: '${widget.data.offer}% OFF',
                      color: appColors.appWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  appText(
                    title: widget.shopData.name ?? '',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  appText(
                    title: widget.data.type ?? '',
                    fontSize: 14,
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              RatingBar.builder(
                wrapAlignment: WrapAlignment.start,
                itemSize: 20,
                initialRating: 4.5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {},
              ),
              // const SizedBox(
              //   height: 6,
              // ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: appColors.appGreen,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      appText(
                        title:
                            '20 Min • ${(Geolocator.distanceBetween(widget.lat, widget.lng, widget.shopData.lat!, widget.shopData.lng!) / 1000).toStringAsFixed(2)} Km',
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: appColors.appBlue,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      appText(
                        title:
                            '${widget.data.timeTaken?.toString()} Min Service',
                      )
                    ],
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Row(
                children: [
                  appText(
                    title:
                        '₹${calculatePrice(double.parse(widget.data.price?.toString() ?? '0'), double.parse(widget.data.offer?.toString() ?? '0'))}',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  appText(
                    title: '₹${widget.data.price}',
                    color: appColors.appGray,
                    textDecoration: TextDecoration.lineThrough,
                    fontSize: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              dataCard(
                texts.detail,
                widget.data.details ?? '',
              ),
              const SizedBox(
                height: 2,
              ),
              dataCard(
                texts.terms,
                widget.data.termAndcondition ?? '',
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin:const EdgeInsets.only(left: 10),
                  child: const Text("Reviews",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin:const EdgeInsets.only(left: 10),
                child: RichText(
                  text: const TextSpan(
                    text: 'John : ',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Good Service!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
        bottomNavigationBar: isbottom == false
            ? SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appColors.appBlue,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (count > 1) {
                              setState(() {
                                count--;
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            color: appColors.appBlack,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Center(
                          child: appText(
                            title: '$count',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: appColors.appBlack,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: appColors.appBlack,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (){
                    if(count == 1 || count >1){
                      setState(() {
                        isbottom = true;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: appColors.appGreen,
                    ),
                    child: Center(
                      child: appText(
                        title: texts.book,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: appColors.appWhite,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
            : Container(
          color: Colors.grey.shade200,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text("${count} Service Added")),
                Container(
                  height: 70,
                  width: 130,
                  decoration: BoxDecoration(
                      color: appColors.appGreen
                  ),
                  child: const Center(child: Text("₹ 2500 View Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                )
              ],
            ),
          ),
        )


    );
  }

  dataCard(String title, String detail) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(
                title: '• $title',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              const SizedBox(
                height: 6,
              ),
              appText(
                title: detail,
                fontSize: 16,
                color: appColors.appGray,
              )
            ],
          ),
        ),
      ),
    );
  }

  calculatePrice(double price, double discount) {
    return (price * (100 - discount) / 100).toStringAsFixed(0);
  }
}