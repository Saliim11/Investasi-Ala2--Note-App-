import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/utils/color.dart';

Future<dynamic> sudahBayarDialog(BuildContext context, int jenis, int index, List list, {required void Function()? onPressed}) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Selesai"),
        content: jenis == 0 ? Text("Yakin udah bayar utangnya ke ${list[index].nama}??")
        : Text("Yakin ${list[index].nama} dah bayar??"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: hijauMuda,
              foregroundColor: hijauTua
            ),
            onPressed: onPressed,
            child: Text("Udah"),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Belom"))
        ],
      );
    },);
  }