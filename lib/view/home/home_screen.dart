import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/detail/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/home/widgets/dialog_tambah_edit_catatan.dart';
import 'package:investasi_ala_ala/view/home/widgets/drop_down_item.dart';
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
    List<Investasi> list = prov.listInvestasi;
    
    DbHelper db = DbHelper();
    Future<List<Investasi>> listInvestasiS = db.getInvestasi();

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
                  child: FutureBuilder(
                    future: listInvestasiS,
                    builder:(context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }else if(snapshot.data!.isEmpty){
                        return Center(child: Teks.spesial("Anda tidak ada catatan pulak"));
                      } else {
                        listPrioritas = snapshot.data!.where((element) => element.isPrio == true).toList();
                        if (listPrioritas.isEmpty) {
                          return Center(child: Teks.spesial("Tidak ada yang diprioritaskan"));
                        } else {
                          return GridView.builder(
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
                          );

                        }
                  
                      }
                    } 
                  ),
                ),
                
                TabDaftarIH(),

                Expanded(
                  // child: tampilanDaftar(0, listInvestasiS),
                  child: FutureBuilder(
                    future: listInvestasiS,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      } else if(snapshot.data!.isEmpty) {
                        return Center(child: Teks.spesial("udah nda ada plus minus lagi duidnya"));
                      } else {
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
                                    IconButton(onPressed: null, icon: Icon(Icons.star_rate_rounded, color: ColorApp.oren,)) : 
                                    IconButton(onPressed: null, icon: Icon(Icons.star_rate_rounded)),
                        
                                    Container(
                                      height: 26,
                                      width: 26,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorApp.kuning
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          customButton: const Icon(Icons.more_vert_outlined, size: 16),
                                          items: [
                                            ...MenuItems.firstItems.map(
                                              (item) => DropdownMenuItem<MenuItem>(
                                                value: item,
                                                child: MenuItems.buildItem(item),
                                              ),
                                            ),
                                            const DropdownMenuItem<Divider>(enabled: false, child: Divider(color: Colors.black,)),
                                            ...MenuItems.secondItems.map(
                                              (item) => DropdownMenuItem<MenuItem>(
                                                value: item,
                                                child: MenuItems.buildItem(item),
                                              ),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            MenuItems.onChanged(context, value! as MenuItem, inv: snapshot.data![index]);
                                            setState(() {});
                                          },
                                          dropdownStyleData: DropdownStyleData(
                                            width: 84,
                                            // padding: const EdgeInsets.symmetric(vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            offset: const Offset(0, 8),
                                          ),
                                          menuItemStyleData: MenuItemStyleData(
                                          customHeights: [
                                            ...List<double>.filled(MenuItems.firstItems.length, 24),
                                            8,
                                            ...List<double>.filled(MenuItems.secondItems.length, 24),
                                          ],
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                        
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                DetailNoteScreen(invest: snapshot.data![index]),)),
                                onLongPress: () {
                                  db.updatePrio(snapshot.data![index].id!, isPrio);
                                  setState(() {});
                                }
                                
                              ),
                            );
                            
                          },
                        );
                      } 
                    }, 
                  ),
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
              // dialogTambahDataIH(context, db, _contNama, _contNominal);
              tambahEditCatatanDialog(context, db);
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