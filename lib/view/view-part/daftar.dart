import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/data_list.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/view/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/view-part/dialog.dart';

Widget tampilanDaftar(int jenis) {
    return StatefulBuilder(
      builder:(context, setState) =>  ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        itemCount: listInvestasi.length,
        itemBuilder: (BuildContext context, int index) {
          
          bool isInvest = listInvestasi[index].isInvest;
          // if (jenis == 0) {
          //   if (isInvest == true) {
          //     return itemBuilder(jenis, context, index, setState);
          //   }
          // }

          if (isInvest == false) {
            return itemBuilder(jenis, context, index, setState);
          }
          
        },
      ),
    );
  }

Card itemBuilder(int jenis, BuildContext context, int index, StateSetter setState) {
  String namaTerkait = listInvestasi[index].nama;
  double nominalUang = listInvestasi[index].nominal;
  bool isPrio = listInvestasi[index].prio;
  return Card(
          child: ListTile(
            title: Text("Rp $nominalUang"),
            subtitle: Row(
              children: [
                Icon(Icons.person, size: 20,),
                Text(namaTerkait),
              ],
            ),
            leading: isPrio ? Badge(
              child: Icon(
                jenis == 0 ? Icons.add : Icons.remove, 
                color: jenis == 0 ? hijau : merah,
              ),
            ) 
            : Icon(
                jenis == 0 ? Icons.add : Icons.remove, 
                color: jenis == 0 ? hijau : merah,
              ),
            trailing: GestureDetector(
              onTap: () {
                sudahBayarDialog(context, jenis, index,
                onPressed: () {
                  setState(() {
                    listInvestasi.removeAt(index);
                  });
                  Navigator.pop(context);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: merahMuda,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Done", style: TextStyle(color: merah),),
              ),
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
}  