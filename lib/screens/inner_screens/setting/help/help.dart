import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../../../utils/custom_textfield.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String _enteredText = "";
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
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
          child: Padding(
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
                    Text(
                      "How can i help you?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: appText(title: "Subject", fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: subjectController,
                    ),
                    SizedBox(
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
                    GestureDetector(
                      onTap: (){
                        helpQueryUser();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appColors.appColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  helpQueryUser() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);

        var body = {
          "vendorId":"36",
          "name":subjectController.text,
          "message":messageController.text
        };
        provider.help(
          context: context,
          body: body,
        );

      },
    );
  }
}
