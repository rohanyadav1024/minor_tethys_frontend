// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/modules/login/login_vm.dart';

import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();

    return GetBuilder<LoginVM>(builder: (c) {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 360.w,
              height: 480.h,
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
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: loginFormkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Login',
                        fontFamily: AppFonts.interBold,
                        fontWeight: FontWeight.w700,
                        size: 20,
                        color: AppColors.lightBlue,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            'Enter Email',
                            style: TextStyle(fontSize: 16),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.bordeColor2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.bordeColor2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => c.usernameCtrl.text = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter username';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text(
                            'Enter Password',
                            style: TextStyle(fontSize: 16),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.bordeColor2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.bordeColor2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.errorColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.errorColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => c.passwordCtrl.text = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter username';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: AppText(
                          text: 'Forgot Password?',
                          color: AppColors.darkblue,
                          fontFamily: AppFonts.interRegular,
                          fontWeight: FontWeight.w400,
                          size: 16.h,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (loginFormkey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            c.login(context: context);
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
                          height: 48.h,
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
                            text: 'Don\'t have an account?',
                            color: AppColors.black,
                            fontFamily: AppFonts.interRegular,
                            fontWeight: FontWeight.w300,
                            size: 15.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.signupView);
                            },
                            child: AppText(
                              text: 'Sign up',
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
      );
    });
  }
}
