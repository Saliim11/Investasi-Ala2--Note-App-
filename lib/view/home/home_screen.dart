import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/widgets/daftar.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog/dialog_tambah_edit_catatan.dart';
import 'package:investasi_ala_ala/view/home/widgets/tab_daftar_i_h.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Investasi> listPrioritas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<InvestasiProvider>(context);
    DbHelper db = DbHelper();
    listPrioritas = prov.listPrioritas;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset("assets/image/background.png", fit: BoxFit.cover,),
              ),
              Expanded(child: Container(
                color: ColorApp.abu,
              ))
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Teks.biasa("Prioritas", fw: FontWeight.w700, fs: 16),
                  ],
                ),

                Container(
                  constraints: BoxConstraints(
                    minHeight: 220
                  ),
                  child: listPrioritas.isEmpty ?
                  Center(child: Teks.spesial("Tidak ada yang diprioritaskan")) :
                  GridView.builder(
                    padding: EdgeInsets.only(bottom: 8),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listPrioritas.length > 4 ? 4 : listPrioritas.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                    ), 
                    itemBuilder: (context, index) {
                      bool isInvest = listPrioritas[index].isInvest;

                      return Container(
                        decoration: BoxDecoration(
                          color: isInvest ? ColorApp.oren :ColorApp.kuning,
                          boxShadow: [
                            BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black.withOpacity(0.25))
                          ]
                        ),
                        height: 20,
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isInvest ?
                            Teks.biasa("Investasi ${listPrioritas[index].nama}", fw: FontWeight.w700, fs: 12) :
                            Teks.biasa("Hutang ${listPrioritas[index].nama}", fw: FontWeight.w700, fs: 12),
                            
                            Teks.biasa("Batas Akhir: ${listPrioritas[index].deadline}", fw: FontWeight.w200, fs: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 21,
                                width: 21,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorApp.abu,
                                  shape: BoxShape.circle
                                ),
                                child: Icon(Icons.arrow_forward, size: 14,),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ),
                
                TabDaftarIH(),

                Expanded(
                  child: IndexedStack(
                    index: prov.isInvestTab,
                    children: [
                      tampilanDaftar(0, prov, db), 
                      tampilanDaftar(1, prov, db), 
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              // dialogTambahDataIH(context, db, _contNama, _contNominal);
              tambahEditCatatanDialog(context, prov);
            },
            backgroundColor: Colors.white,
            shape: CircleBorder(side: BorderSide(width: 1)),
            child: Icon(Icons.add, color: Colors.black, size: 40,),
          ),
        ),
      ),
    );
  }
}