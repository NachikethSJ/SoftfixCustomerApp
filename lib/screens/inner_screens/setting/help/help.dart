import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validate_connectivity.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../../../constants/texts.dart';
import '../../../../utils/custom_textfield.dart';
import '../../../../utils/loading_shimmer.dart';
import '../../../../view_models/accounts_provider.dart';

class HelpPage extends StatefulWidget {
   String? vendorId;
   HelpPage({super.key, this.vendorId});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String _enteredText = "";
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHelpLastMessage();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Help"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Consumer<DashboardProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help,
                          size: 50,
                          color: appColors.appColor,
                        ),
                        const Text(
                          "How can i help you?",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: appText(title: "Subject", fontSize: 16)),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: subjectController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: appText(title: "Message", fontSize: 16)),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          maxLength: 500,
                          maxLines: 4,
                          controller: messageController,
                          hintText: "Enter Message",
                          onChanged: (value) {
                            setState(() {
                              _enteredText = value.toString();
                            });
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              appText(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                title: '${_enteredText.length.toString()}/500',
                                color: Colors.blueGrey,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Consumer<DashboardProvider>(
                          builder: (context, provider, child) {
                            return AppButton(
                                isLoading:provider.showLoader,
                                onPressed: () {
                                  helpQueryUser();
                                }, title: 'Submit', radius: 12);
                          },
                        ),
                        Consumer<AccountsProvider>(
                          builder: (context, provider, child) {
                            if (provider.showLoader) {
                              return ListView.separated(
                                itemCount: 4,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 14,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 100,
                                    width: 130,
                                    child: loadingShimmer(),
                                  );
                                },
                              );
                            } else if (provider.getHelpMessageList.isEmpty) {
                              return Center(
                                heightFactor:10,
                                child: appText(title: 'No Messages from Shopkeeper'),
                              );
                            }
                          return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.yellow,width: 1)
                              ),
                              child: Row(
                                children: [
                                  Text("Last Message:- "),
                                  appText(title: provider.getHelpMessageList[0].message??"")
                                  //Text("${provider.getHelpMessageList[0].message}"),
                                ],
                              ),
                            ),
                          ],
                        );
                        },
                      ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  helpQueryUser() {
    validateConnectivity(context: context, provider: () {
      var provider = Provider.of<DashboardProvider>(context, listen: false);

      var body = {
        "vendorId": widget.vendorId,
        "name": subjectController.text,
        "message": messageController.text
      };
      provider.help(
        context: context,
        body: body,
      ).then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    });
  }

  getHelpLastMessage() {
    validateConnectivity(context: context, provider: () {
      var provider = Provider.of<AccountsProvider>(context, listen: false);

      provider.getHelpMessageDetail(context: context, body: {
        "vendorId": widget.vendorId,
      });
    });
  }
}
