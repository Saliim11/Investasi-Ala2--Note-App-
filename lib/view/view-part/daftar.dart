import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/data_list.dart';
import 'package:investasi_ala_ala/utils/color.dart';
import 'package:investasi_ala_ala/view/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/view-part/dialog.dart';

Widget tampilanDaftar() {
    return StatefulBuilder(
      builder:(context, setState) =>  ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        itemCount: listInvestasi.length,
        itemBuilder: (BuildContext context, int index) {
          String namaTerkait = listInvestasi[index].nama;
          double nominalUang = listInvestasi[index].nominal;
          bool isPrio = listInvestasi[index].prio;
          bool isInvest = listInvestasi[index].isInvest;
          if (isInvest) {
            
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
                    isInvest  ? Icons.add : Icons.remove, 
                    color: isInvest  ? hijau : merah,
                  ),
                ) 
                : Icon(
                    isInvest  ? Icons.add : Icons.remove, 
                    color: isInvest  ? hijau : merah,
                  ),
                trailing: GestureDetector(
                  onTap: () {
                    sudahBayarDialog(context, isInvest, index,
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
        },
      ),
    );
  }  