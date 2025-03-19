import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/button_style.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';

void showDoneDialog(BuildContext context, String text, {required String imgUrl}) {
  showDialog(context: context, builder: (context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.25,
        horizontal: 24
      ),
      shape: RoundedRectangleBorder(),
      surfaceTintColor: ColorApp.abu,
      child: Container(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 54),
        color: ColorApp.abu,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(imgUrl),
                  Teks.spesial(text, fs: 20)
                ],
              ),
              SizedBox(
                height: 27,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  style: TombolS.stylAcc,
                  child: Teks.biasa("Sipp"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  });
}