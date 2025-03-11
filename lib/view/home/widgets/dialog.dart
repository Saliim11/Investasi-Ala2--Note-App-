import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/data/db_helper.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';

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
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Skip"))
        ],
      );
    });
  });
}