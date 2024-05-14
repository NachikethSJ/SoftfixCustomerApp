import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/screens/common_screens/bottom_navigation.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/utils/show_toast.dart';
import 'package:salon_customer_app/utils/validate_connectivity.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOtp extends StatefulWidget {
  final TextEditingController number;
  const VerifyOtp({super.key, required this.number});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();

  _fetchOtp() async {
    await SmsAutoFill().listenForCode();
    SmsAutoFill().getAppSignature.then((signature) async {
      print("====$signature");
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), _fetchOtp);
  }

  @override
  void codeUpdated() {
    print("=======$code");
    setState(() {
      otpController.text = code ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child:
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.verified_user_sharp,
                          size: 120,
                          color: appColors.appColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      appText(
                        title: texts.otpTitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: appText(
                          title: '${texts.otpSubTitle}\n${widget.number.text}',
                          fontSize: 14,
                          color: appColors.appGray,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                          child: Column(
                            children: [
                              Center(
                                child: PinCodeTextField(
                                  pinBoxColor: appColors.appGray100,
                                  controller: otpController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  pinBoxHeight:
                                      MediaQuery.of(context).size.height / 16,
                                  pinBoxWidth:
                                      MediaQuery.of(context).size.width / 7,
                                  pinBoxRadius: 8,
                                  autofocus: true,
                                  pinBoxOuterPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  defaultBorderColor: appColors.appWhite,
                                  pinBoxBorderWidth: 1,
                                  errorBorderColor: appColors.appRed,
                                  onTextChanged: (value) {},
                                  onDone: (text) {
                                    _verifyOtp(provider);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 36, left: 36),
                                child: AppButton(
                                  textColor: appColors.appWhite,
                                  isLoading: provider.showLoader,
                                  onPressed: () {
                                    _verifyOtp(provider);
                                  },
                                  title: texts.verify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _verifyOtp(AuthProvider provider) {
    validateConnectivity(
        context: context,
        provider: () {
          if (otpController.text.isEmpty) {
            showToast('Please enter OTP.');
          } else {
            provider.verifyOtp(
              body: {
                'mobileNo': widget.number.text.replaceAll('+91', ''),
                'otp': otpController.text,
              },
            ).then((value) {
              if (value) {
                navigateRemoveUntil(
                    context: context, to: const BottomNavigation());
              }
            });
          }
        });
  }
}
