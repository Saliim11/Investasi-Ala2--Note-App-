import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/db_helper.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog.dart';

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final Icon icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [edit];
  static const List<MenuItem> secondItems = [delete];

  static const edit = MenuItem(text: 'Edit', icon: Icon(Icons.edit, size: 11,));
  static const delete = MenuItem(text: 'Hapus', icon: Icon(Icons.delete_outline, color: Colors.red, size: 11,));

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        SizedBox(width: 10),
        item.icon,
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Teks.biasa(item.text, fs: 12)
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, {required Investasi inv}) async{
    DbHelper db = DbHelper();

    switch (item) {
      case MenuItems.edit:
        tambahEditCatatanDialog(context, db,
          id: inv.id,
          nama: inv.nama,
          nominal: inv.nominal,
          isInvest: inv.isInvest,
          tglMulai: inv.tglMulai,
          deadline: inv.deadline,
          deskripsi: inv.deskripsi,
          isEdit: true
        );
        break;
      case MenuItems.delete:
        await db.deleteInvestasi(inv.id!);
        break;
    }
  }

}