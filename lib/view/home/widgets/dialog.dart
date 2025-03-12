import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/data/db_helper.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';

Future<dynamic> sudahBayarDialog(BuildContext context, int jenis, int index, {required void Function()? onPressed}) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Selesai"),
        content: jenis == 0 ? Text("Yakin udah bayar utangnya ke ${listInvestasi[index].nama}??")
        : Text("Yakin ${listInvestasi[index].nama} dah bayar??"),
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

Future<dynamic> dialogTambahDataIH(BuildContext context, DbHelper help, TextEditingController _contNama, TextEditingController _contNominal) {
  return showDialog(context: context, builder: (context) { 
    int selectedCategory = 0;

    return StatefulBuilder(
      builder:(context, setState) {

      return  AlertDialog(
        title: Text("Tambah Data"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState((){
                          selectedCategory = 0;
                        });
                        
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedCategory == 0 ? biruMuda : abu
                            )
                          )
                        ),
                        child: Text("Investasi"),
                      ),
                    )
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState((){
                          selectedCategory = 1;
                        });
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedCategory == 1 ? biruMuda : abu
                            )
                          )
                        ),
                        child: Text("Hutang"),
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _contNama,
                decoration: InputDecoration(
                  label: Text("Nama"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.number,
                controller: _contNominal,
                decoration: InputDecoration(
                  label: Text("Nominal"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: ()  async{
              String tgl = DateFormat('dd MMM yyyy').format(DateTime.now());

              if (selectedCategory == 0) {

                bool result = await help.insertInvestasi(
                  Investasi(nama: _contNama.text, nominal: double.parse(_contNominal.text), deskripsi: "halohalo", tglMulai: tgl, deadline: tgl, isPrio: false, isInvest: true)
                );

                if (result == true) {
                  print("Berhasil kirim data");
                }

                _contNama.clear();
                _contNominal.clear();
                
                Navigator.pop(context);
                
              } else if (selectedCategory == 1) {
                
                bool result = await help.insertInvestasi(
                Investasi(nama: _contNama.text, nominal: double.parse(_contNominal.text), deskripsi: "halohalo", tglMulai: tgl, deadline: tgl, isPrio: false, isInvest: false)
                );

                if (result == true) {
                  print("Berhasil kirim data");
                }

                _contNama.clear();
                _contNominal.clear();
              
                Navigator.pop(context);

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: hijauMuda,
              foregroundColor: hijauTua
            ),
            child: Text("Simpan"),
          ),
          TextButton(onPressed: () {
            _contNama.clear();
            _contNominal.clear();
             Navigator.pop(context);
          }, 
          child: Text("Skip"))
        ],
      );
    });
  });
}

Future<dynamic> tambahEditCatatanDialog(BuildContext context, DbHelper db,
{ int? id, String? nama, double? nominal, bool? isInvest, String? tglMulai, String? deadline, String? deskripsi, bool? isEdit = false }) {
  
  final List<String> itemss = [
    'Investasi',
    'Hutang',
  ];
  TextEditingController cNama = TextEditingController();
  TextEditingController cNominal = TextEditingController();
  TextEditingController cTglMulai = TextEditingController();
  TextEditingController cDeadline = TextEditingController();
  TextEditingController cDeskripsi = TextEditingController();
  String? selectedCatg;

  if (isEdit!) {
    cNama = TextEditingController(text: nama);
    cNominal = TextEditingController(text: "$nominal");
    cTglMulai = TextEditingController(text: tglMulai);
    cDeadline = TextEditingController(text: deadline);
    cDeskripsi = TextEditingController(text: deskripsi);
  }

  void resetCont(){
    cNama.clear();
    cNominal.clear();
    cTglMulai.clear();
    cDeadline.clear();
    cDeskripsi.clear();
    selectedCatg = "";
  }
  
  return showDialog(context: context, builder: (context) {
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
                        child: isEdit ? Teks.biasa("Edit Data", fs: 20) : Teks.biasa("Tambah Data", fs: 20),
                      ),
                    )
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textfieldTemp("A/N", "Masukkan nama", cont: cNama),
                      SizedBox(height: 10),
                      isEdit ? dropDownTemp("Catatan untuk", "Pilih tujuan catatan", itemss, selectedCatg, isEdit: isEdit, isInvest: isInvest) : dropDownTemp("Catatan untuk", "Pilih tujuan catatan", itemss, selectedCatg),
                      SizedBox(height: 10),
                      textfieldTemp("Nominal", "Masukkan nominal", cont: cNominal),
                      SizedBox(height: 10),
                      textfieldDatePick(context, "Tanggal Dimulai", "Masukkan tanggal", cont: cTglMulai),
                      SizedBox(height: 10),
                      textfieldDatePick(context, "Batas Waktu", "Masukkan deadline", cont: cDeadline),
                      SizedBox(height: 10),
                      textfieldTemp("Deskripsi", "Silahkan masukkan deskripsi\nsingkat data anda !", tinggi: 98, cont: cDeskripsi),
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
                                    resetCont();
                                    Navigator.pop(context);
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
                                    bool result;
                                    if (isEdit) {
                                      bool isInvest = selectedCatg == itemss.first;
                                      await db.updateInvest(id!, nama: cNama.text, nominal: double.parse(cNominal.text), isInvest: isInvest, tglMulai: cTglMulai.text, deadline: cDeadline.text, deskripsi: cDeskripsi.text);
                                    } else {
                                      if (selectedCatg == itemss.first) {
                                        result = await db.insertInvestasi(
                                          Investasi(nama: cNama.text, nominal: double.parse(cNominal.text), deskripsi: cDeskripsi.text, tglMulai: cTglMulai.text, deadline: cDeadline.text, isPrio: false, isInvest: true)
                                        );
                                      } else {
                                        result = await db.insertInvestasi(
                                          Investasi(nama: cNama.text, nominal: double.parse(cNominal.text), deskripsi: cDeskripsi.text, tglMulai: cTglMulai.text, deadline: cDeadline.text, isPrio: false, isInvest: false)
                                        );
                                      }
                                      if (result == true) {
                                        print("Berhasil kirim data");
                                      }
                                    }
                                    
        
                                    resetCont();
                                    Navigator.pop(context);
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
  }

Row textfieldTemp(String title, String ht, {required TextEditingController cont ,double? tinggi = 30}) {
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
Row textfieldDatePick(BuildContext context, String title, String ht, {required TextEditingController cont ,double? tinggi = 30}) {
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
          child: GestureDetector(
            onTap: () async{
              DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat("dd MMM yyyy").format(pickedDate);
              cont.text = formattedDate;
            }
            },
            child: AbsorbPointer(
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
          ),
        ),
      )
    ],
  );
}

Row dropDownTemp(String title, String ht, List itemss, String? selected, {bool? isEdit = false, bool? isInvest}) {
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
          height: 30,
          child: DropdownButtonFormField2<String>(
            value: isEdit! ?  isInvest! ? itemss.first : itemss.last : null,
            isExpanded: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: ht,
              hintStyle: TextStyle(
                fontSize: 12
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: const Text(
              'Pilih tujuan catatan',
              style: TextStyle(fontSize: 11),
            ),
            items: itemss
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              //Do something when selected item is changed.
              selected = value.toString();
            },
            onSaved: (value) {
              
            },
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
          ),
        ),
      )
    ],
  );
}