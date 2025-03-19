import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/button_style.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog/dialog_done.dart';

void showBfrDelete(BuildContext context, int id, InvestasiProvider prov) {
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
                  Image.asset("assets/image/duck1.png"),
                  Teks.spesial("Yakin mau hapus catatan ini bro ?", fs: 20)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 27,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      style: TombolS.stylDecl,
                      child: Teks.biasa("Gak Dulu"),
                    ),
                  ),
                  SizedBox(
                    height: 27,
                    child: ElevatedButton(
                      onPressed: () {
                        prov.deleteItem(id);
                        Navigator.pop(context);
                        showDoneDialog(context, "Sudah berhasil dihapus...\nTenang, nggak pake sulap kok!", imgUrl: "assets/image/chick2.png");
                      }, 
                      style: TombolS.stylAcc,
                      child: Teks.biasa("Yoii"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}