// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30 * fem),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xfff4faff), Color(0xffacd2e3)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "User List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34 * fem, // Adjust font size
                fontWeight: FontWeight.w700,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "Nothing to show here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25 * fem, // Adjust font size
                fontWeight: FontWeight.w400,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
