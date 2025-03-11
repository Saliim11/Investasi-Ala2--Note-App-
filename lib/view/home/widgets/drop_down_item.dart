import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/db_helper.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';

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

  static void onChanged(BuildContext context, MenuItem item, int id) async{
    DbHelper db = DbHelper();

    switch (item) {
      case MenuItems.edit:
        showDialog(context: context, builder: (context) {
          final List<String> items = [
            'Investasi',
            'Hutang',
          ];
          
          final TextEditingController _cNama = TextEditingController();
          final TextEditingController _cNominal = TextEditingController();
          final TextEditingController _cTglMulai = TextEditingController();
          final TextEditingController _cDeadline = TextEditingController();
          final TextEditingController _cDeskripsi = TextEditingController();

          String? selectedCatg;

          void resetCont(){
            _cNama.clear();
            _cNominal.clear();
            _cTglMulai.clear();
            _cDeadline.clear();
            _cDeskripsi.clear();
            selectedCatg = "";
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width /2.5),
            child: Dialog(
              shape: RoundedRectangleBorder(),
              surfaceTintColor: ColorApp.abu,
              child: Container(
                color: ColorApp.abu,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 16),
                            height: 50,
                            decoration: BoxDecoration(
                              color: ColorApp.abu,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4
                                )
                              ]
                            ),
                            child: Teks.biasa("Edit Data", fs: 20),
                          ),
                        )
                      ],
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textfieldTemp("A/N", "Masukkan nama", cont: _cNama),
                          SizedBox(height: 10),
                          dropDownTemp("Catatan untuk", "Pilih tujuan catatan", cont: _cNama),
                          SizedBox(height: 10),
                          textfieldTemp("Nominal", "Masukkan nominal", cont: _cNominal),
                          SizedBox(height: 10),
                          textfieldTemp("Tanggal Dimulai", "Masukkan tanggal", cont: _cTglMulai),
                          SizedBox(height: 10),
                          textfieldTemp("Batas Waktu", "Masukkan deadline", cont: _cDeadline),
                          SizedBox(height: 10),
                          textfieldTemp("Deskripsi", "Silahkan masukkan deskripsi\nsingkat data anda !", tinggi: 98, cont: _cDeskripsi),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16),
                              height: 50,
                              decoration: BoxDecoration(
                                color: ColorApp.abu,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, -2),
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 27,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        shape: BeveledRectangleBorder(),
                                        backgroundColor: ColorApp.oren,
                                        foregroundColor: Colors.black
                                      ),
                                      child: Teks.biasa("Batal")
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                  SizedBox(
                                    height: 27,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        bool result = await db.insertInvestasi(
                                          Investasi(nama: _cNama.text, nominal: double.parse(_cNominal.text), deskripsi: _cDeskripsi.text, tglMulai: _cTglMulai.text, deadline: _cDeadline.text, isPrio: false, isInvest: true)
                                        );

                                        if (result == true) {
                                          print("Berhasil kirim data");
                                        }
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        shape: BeveledRectangleBorder(),
                                        backgroundColor: ColorApp.hijau,
                                        foregroundColor: Colors.black
                                      ),
                                      child: Teks.biasa("Simpan")
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
        break;
      case MenuItems.delete:
        await db.deleteInvestasi(id);
        break;
    }
  }

  static Row textfieldTemp(String title, String ht, {required TextEditingController cont ,double? tinggi = 30}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2, 
          child: Align(
            alignment: Alignment.topLeft,
            child: Teks.biasa("$title *", fs: 11
            )
          )
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: tinggi,
            child: TextField(
              controller: cont,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ht,
                hintStyle: TextStyle(
                  fontSize: 12
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: null,
            ),
          ),
        )
      ],
    );
  }
  static Row dropDownTemp(String title, String ht, {required TextEditingController cont ,double? tinggi = 30}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2, 
          child: Align(
            alignment: Alignment.topLeft,
            child: Teks.biasa("$title *", fs: 11
            )
          )
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: tinggi,
            child: TextField(
              controller: cont,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ht,
                hintStyle: TextStyle(
                  fontSize: 12
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: null,
            ),
          ),
        )
      ],
    );
  }
}