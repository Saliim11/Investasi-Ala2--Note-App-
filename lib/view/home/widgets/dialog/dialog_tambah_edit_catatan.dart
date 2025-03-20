import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog/dialog_done.dart';

String? selectedCatg;

Future<dynamic> tambahEditCatatanDialog(BuildContext context, InvestasiProvider prov,
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

  if (isEdit!) {
    cNama = TextEditingController(text: nama);
    cNominal = TextEditingController(text: "${nominal!.round()}");
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
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width /2.5,
          horizontal: 24
        ),
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
                padding: const EdgeInsets.only(top: 66.0, left: 16, right: 16,),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textfieldTemp("A/N", "Masukkan nama", cont: cNama, isText: true),
                        SizedBox(height: 10),
                        isEdit ? dropDownTemp("Catatan untuk", "Pilih tujuan catatan", itemss, isEdit: isEdit, isInvest: isInvest) : dropDownTemp("Catatan untuk", "Pilih tujuan catatan", itemss),
                        SizedBox(height: 10),
                        textfieldTemp("Nominal", "Masukkan nominal", cont: cNominal, isText: false),
                        SizedBox(height: 10),
                        textfieldDatePick(context, "Tanggal Dimulai", "Masukkan tanggal", cont: cTglMulai),
                        SizedBox(height: 10),
                        textfieldDatePick(context, "Batas Waktu", "Masukkan deadline", cont: cDeadline),
                        SizedBox(height: 10),
                        textfieldTemp("Deskripsi", "Silahkan masukkan deskripsi\nsingkat data anda !", tinggi: 98, cont: cDeskripsi, isText: true),
                      ],
                    ),
                  ),
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
                                  if (isEdit) {
                                    bool isInvest = selectedCatg == itemss.first;
                                    prov.editInvestasi(id!, cNama.text, double.parse(cNominal.text), isInvest, cTglMulai.text, cDeadline.text, cDeskripsi.text);
      
                                  } else {
                                    if (selectedCatg == itemss.first) {
                                      prov.addItemInvestasi(
                                        Investasi(nama: cNama.text, nominal: double.parse(cNominal.text), deskripsi: cDeskripsi.text, tglMulai: cTglMulai.text, deadline: cDeadline.text, isPrio: false, isInvest: true)
                                      );
                                    } else {
                                      prov.addItemInvestasi(
                                        Investasi(nama: cNama.text, nominal: double.parse(cNominal.text), deskripsi: cDeskripsi.text, tglMulai: cTglMulai.text, deadline: cDeadline.text, isPrio: false, isInvest: false)
                                      );
                                    }
                                  }
                                  print("Mengirim data : $selectedCatg ${selectedCatg == itemss.first}");
      
                                  resetCont();
                                  Navigator.pop(context);
      
                                  showDoneDialog(context, "Udah kesimpen ya", imgUrl: "assets/image/chick2.png");
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
      );
    });
  }

Row textfieldTemp(String title, String ht, {required TextEditingController cont, required bool isText ,double? tinggi = 30}) {
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
            keyboardType: isText ? TextInputType.text : TextInputType.number,
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
Row textfieldDatePick(BuildContext context, String title, String ht, {required TextEditingController cont}) {
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

Row dropDownTemp(String title, String ht, List itemss, {bool? isEdit = false, bool? isInvest}) {
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
              selectedCatg = value.toString();
              print("isi kategori : $selectedCatg");
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