import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/view/home/detail/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog.dart';
import 'package:investasi_ala_ala/view/home/widgets/text.dart';

Widget tampilanDaftar(int jenis) {
  return StatefulBuilder(
    builder:(context, setState) =>  ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemCount: listInvestasi.length,
      itemBuilder: (BuildContext context, int index) {
        String namaTerkait = listInvestasi[index].nama;
        double nominalUang = listInvestasi[index].nominal;
        String tgl = DateFormat('dd MMM yyyy').format(listInvestasi[index].tglMulai);
        bool isPrio = listInvestasi[index].prio;
        bool isInvest = listInvestasi[index].isInvest;
        return Card(
          child: ListTile(
            title: isInvest ? 
            teksMainScreen("Investasi ke $namaTerkait", fs: 14, fw: FontWeight.w700) : 
            teksMainScreen("Hutang ke $namaTerkait", fs: 14, fw: FontWeight.w700),
            subtitle: teksMainScreen(tgl, fs: 10, fw: FontWeight.w200),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isPrio ? 
                IconButton(onPressed: (){}, icon: Icon(Icons.star_rate_rounded, color: ColorApp.oren,)) : 
                IconButton(onPressed: (){}, icon: Icon(Icons.star_rate_rounded)),

                Container(
                  height: 26,
                  width: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorApp.kuning
                  ),
                  child: Icon(Icons.more_vert_outlined, size: 16,),
                )
              ],
            ),

            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
            DetailNoteScreen(invest: listInvestasi[index]),)),
            onLongPress: () {
              setState((){
                listInvestasi[index].prio = !listInvestasi[index].prio;
              });
            }
            
          ),
        );
        
      },
    ),
  );
}


// onTap: () {
              //   sudahBayarDialog(context, jenis, index,
              //   onPressed: () {
              //     setState(() {
              //       listInvestasi.removeAt(index);
              //     });
              //     Navigator.pop(context);
              //   });
              // },