import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/screens/auth_screens/verify_otp.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/app_text_field.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/utils/show_toast.dart';
import 'package:salon_customer_app/utils/validate_connectivity.dart';
import 'package:salon_customer_app/utils/validator.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobileNumber = TextEditingController();

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      mobileNumber.text = phone;
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), _tryPasteCurrentPhone);
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
                      Icon(
                        Icons.send_to_mobile_outlined,
                        size: 120,
                        color: appColors.appColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      appText(
                        title: texts.loginTitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: appText(
                          title: texts.loginSubTitle,
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
                              AppTextField(
                                // filled: true,
                                hintText: texts.mobileNumber,
                                keyBoardType: TextInputType.number,
                                controller: mobileNumber,
                                onFieldSubmitted: (p0) {
                                  _login(provider);
                                },
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
                                    _login(provider);
                                  },
                                  title: texts.continues,
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

  _login(AuthProvider provider) {
    validateConnectivity(
        context: context,
        provider: () {
          if (mobileNumber.text.isEmpty) {
            showToast('Please enter mobile number.');
          } else if (!isNumberValid(mobileNumber.text.replaceAll('+91', ''))) {
            showToast('Please enter valid number.');
          } else {
            provider.login(body: {
              'mobileNo': mobileNumber.text.replaceAll('+91', ''),
            }).then((value) {
              if (value) {
                slideTransition(
                    context: context, to: VerifyOtp(number: mobileNumber));
              }
            });
          }
        });
  }
}
