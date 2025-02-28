import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/utils/color.dart';
import 'package:investasi_ala_ala/view/view-part/dialog.dart';

Expanded tampilanDaftar(List<dynamic> list, int jenis) {
    return Expanded(
      child: StatefulBuilder(
        builder:(context, setState) =>  ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text("Rp ${list[index].nominal}"),
                subtitle: Row(
                  children: [
                    Icon(Icons.person, size: 20,),
                    Text(list[index].nama),
                  ],
                ),
                leading: Badge(
                  child: Icon(
                    jenis == 0 ? Icons.add : Icons.remove, 
                    color: jenis == 0 ? hijau : merah,
                  ),
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
                
              ),
            );
          },
        ),
      ),
    );
  }  