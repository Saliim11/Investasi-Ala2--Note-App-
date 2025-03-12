import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/detail/detail_note_screen.dart';

Widget tampilanDaftar(int jenis, Future<List<Investasi>> listInvestasi) {
  return StatefulBuilder(
    builder:(context, setState) =>  FutureBuilder(
      future: listInvestasi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            // reverse: true,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              String namaTerkait = snapshot.data?[index].nama ?? "";
              // double nominalUang = snapshot.data?[index].nominal ?? 0;
              String tgl = snapshot.data?[index].tglMulai ?? "";
              bool isPrio = snapshot.data?[index].isPrio ?? false;
              bool isInvest = snapshot.data?[index].isInvest ?? false;
              return Card(
                child: ListTile(
                  title: isInvest ? 
                  Teks.biasa("Investasi ke $namaTerkait", fs: 14, fw: FontWeight.w700) : 
                  Teks.biasa("Hutang ke $namaTerkait", fs: 14, fw: FontWeight.w700),
                  subtitle: Teks.biasa(tgl, fs: 10, fw: FontWeight.w200),
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
                  DetailNoteScreen(invest: snapshot.data![index]),)),
                  onLongPress: () async{
                    DbHelper db = DbHelper();
                    await db.updatePrio(snapshot.data![index].id!, isPrio);
                    setState(() {});
                  }
                  
                ),
              );
              
            },
          );
        } else if(snapshot.data== []|| snapshot.data == null) {
          return Teks.spesial("Data kosong");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );

        }
      }, 
    ),
  );
}