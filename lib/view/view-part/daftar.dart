import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/utils/color.dart';
import 'package:investasi_ala_ala/view/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/view-part/dialog.dart';

Widget tampilanDaftar(List<dynamic> list, int jenis) {
    return StatefulBuilder(
      builder:(context, setState) =>  ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          String namaTerkait = list[index].nama;
          double nominalUang = list[index].nominal;
          bool isPrio = list[index].prio;
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
                  sudahBayarDialog(context, jenis, index, list,
                  onPressed: () {
                    setState(() {
                      list.removeAt(index);
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
              DetailNoteScreen(nama: namaTerkait, nominal: nominalUang, deskripsi: list[index].deskripsi, tglMulai: list[index].tglMulai, deadline: list[index].deadline,),)),
              // onLongPress: () {
              //   setState((){
              //     list.elementAt(index).prio = true;
              //   });
              // }
              
            ),
          );
        },
      ),
    );
  }  