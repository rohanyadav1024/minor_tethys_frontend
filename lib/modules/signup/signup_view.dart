// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tethys/modules/signup/signup_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'package:tethys/utils/widgets/app_text_form_fied.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

    return GetBuilder<SignupVM>(builder: (c) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage(AppImages.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 360,
              height: 560,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.bgColor,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.bordercolor, width: 9.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: signupFormkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Register',
                          fontFamily: AppFonts.interBold,
                          fontWeight: FontWeight.w700,
                          size: 20,
                          color: AppColors.lightBlue,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppTextFormField(
                          controller: c.nameCtrl,
                          labelText: 'Enter Name',
                          textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppTextFormField(
                          controller: c.emailCtrl,
                          labelText: 'Enter email',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          items: <String>[
                            'Gatekeeper',
                            'Product Manager',
                            'Stock Manager',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            c.roleCtrl.text = newValue!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Select role',
                            filled: true,
                            fillColor: AppColors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.bordeColor2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.bordeColor2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppTextFormField(
                          controller: c.phoneCtrl,
                          labelText: 'Enter Phone',
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppTextFormField(
                          controller: c.passwordCtrl,
                          labelText: 'Enter Password',
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (signupFormkey.currentState!.validate()) {
                              c.signup(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 48.h),
                            elevation: 5.0,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: AppColors.buttonColor, begin: Alignment.topLeft, end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: AppText(
                              text: 'Submit',
                              color: AppColors.white,
                              fontFamily: AppFonts.interRegular,
                              fontWeight: FontWeight.w400,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: 'Already have an account?',
                              color: AppColors.black,
                              fontFamily: AppFonts.interRegular,
                              fontWeight: FontWeight.w300,
                              size: 15.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offNamed(AppRoutes.loginView);
                              },
                              child: AppText(
                                text: 'Login',
                                color: AppColors.darkblue,
                                fontFamily: AppFonts.interRegular,
                                fontWeight: FontWeight.w400,
                                size: 16.h,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
