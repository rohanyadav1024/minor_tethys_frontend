// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/common.dart';

class ReturnMaterials extends StatelessWidget {
  const ReturnMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(
      builder: (c) {
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
              body: SingleChildScrollView(
                child: Column(children: [
                  headerRow(headerText: 'Return Materials', onRefresh: () {}),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    child: Container(
                      height: 800.h,
                      child: Form(
                        key: c.formKey,
                        child: ListView.builder(
                          itemCount: c.currentReqMaterials.length,
                          itemBuilder: (context, index) {
                            final item = c.currentReqMaterials[index].matDetails!.material;
                            final remainingQty =
                                (c.currentReqMaterials[index].qtyIssued! - c.currentReqMaterials[index].qtyConsumed!);
                            c.returnedMaterialsList.add({'req_id': c.currentReqMaterials[index].reqId});
                            c.returnedMaterialsList[index]['mat_id'] = c.currentReqMaterials[index].matDetails!.id;
                            c.returnedMaterialsList[index]['qty'] = 0;

                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: ListTile(
                                title: Text(item!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Req Id: ${c.currentReqMaterials[index].reqId.toString()}'),
                                    Text('Issued: ${c.currentReqMaterials[index].qtyIssued.toString()}'),
                                    Text('Consumed: ${c.currentReqMaterials[index].qtyConsumed.toString()}'),
                                    Text('Remaining: $remainingQty'),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Qty',
                                    ),
                                    onChanged: (value) {
                                      final qty = int.tryParse(value);
                                      c.returnedMaterialsList[index]['qty'] = qty;
                                    },
                                    validator: (value) {
                                      final qty = int.parse(value ?? '0');
                                      return qty > remainingQty ? 'Invalid' : null;
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (c.formKey.currentState?.validate() ?? false) {
                    debugPrint(c.returnedMaterialsList.toString());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alert !!'),
                          content: Text('Continuing will mark this slot as completed'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Get.back();
                                await c.returnMaterial(context);
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Icon(Icons.save),
              ),
            ),
          ),
        );
      },
    );
  }
}