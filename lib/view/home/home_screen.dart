import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/data/db_helper.dart';
import 'package:investasi_ala_ala/data/dummy_data.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/widgets/daftar.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  // int _selectedPage = 0;

  final TextEditingController _contNama = TextEditingController();
  final TextEditingController _contNominal = TextEditingController();

  // void _changePage(int index) {
  //   setState(() {
  //     _selectedPage = index;
  //   });
  // }

  // void _changePriority(int index){
  //   setState(() {
  //     listInvestasi[index].isPrio = true;
  //   });
  // }
  List<Investasi> listPrioritas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPrioritas = listInvestasi.where((element) => element.isPrio == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    DbHelper help = DbHelper();
    Future<List<Investasi>> listInvestasiS = help.getInvestasi();

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
                    Teks.biasa("Semua Catatan", fw: FontWeight.w700, fs: 16),
                    
                    Row(
                      children: [
                        Icon(Icons.search, color: Colors.black,),
                        SizedBox(width: 25,),
                        Icon(Icons.history, color: Colors.black,)
                      ],
                    )
                  ],
                ),

                GridView.builder(
                  padding: EdgeInsets.only(bottom: 8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listPrioritas.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ), 
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: BeveledRectangleBorder(),
                      color: ColorApp.kuning,
                      child: Container(
                        height: 20,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Teks.biasa("Save money to ${listPrioritas[index].nama}", fw: FontWeight.w700, fs: 12),
                            Teks.biasa("Deadline: ${listPrioritas[index].deadline}", fw: FontWeight.w200, fs: 10),
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
                      ),
                    );
                  },
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Teks.biasa("Terbaru", fs: 12, fw: FontWeight.w600),
                    Teks.biasa("Lihat semua", fs: 10, fw: FontWeight.w300),
                  ],
                ),

                Expanded(
                  child: tampilanDaftar(0, listInvestasiS),
                )

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
              dialogTambahDataIH(context, help, _contNama, _contNominal);
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