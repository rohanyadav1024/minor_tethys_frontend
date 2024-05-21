// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/common.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchiveVM>(
      builder: (c) {
        c.topPadding = MediaQuery.paddingOf(context).top;
        c.context = context;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.bgGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        headerRow(headerText: 'Archives', onRefresh: () {}),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.bordeColor2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: AppColors.bordeColor2),
                                  ),
                                ),
                                value: c.selectedOption,
                                items: ['Requests', 'Returns'].map(
                                  (item) {
                                    return DropdownMenuItem(
                                      child: Text(item),
                                      value: item,
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  c.PageCounter = -1;

                                  c.selectedOption = value!;
                                  c.update();
                                  c.onSelectedOptionChange();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        c.lVContainer!,
                      ],
                    ),
                  ),
                  c.isloading!
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
