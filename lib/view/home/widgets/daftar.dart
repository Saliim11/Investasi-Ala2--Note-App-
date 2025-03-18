import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/detail/detail_note_screen.dart';
import 'package:investasi_ala_ala/view/home/widgets/drop_down_item.dart';

Widget tampilanDaftar(int jenis, InvestasiProvider prov, DbHelper db) {
  List<Investasi> list = [];
  if (jenis == 0) {
    list = prov.listInvestasi.where((element) => element.isInvest == true).toList();
  } else {
    list = prov.listInvestasi.where((element) => element.isInvest == false).toList();
  }

  if (list == [] || list.isEmpty) {
    print(list);
    return Center(child: Teks.spesial("udah nda ada plus minus lagi duidnya",));
    
  } else {
    return ListView.builder(
      // reverse: true,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        String namaTerkait = list[index].nama;
        // double nominalUang = snapshot.data?[index].nominal ?? 0;
        String tgl = list[index].tglMulai;
        bool isPrio = list[index].isPrio;
        bool isInvest = list[index].isInvest;
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
                        MenuItems.onChanged(context, value! as MenuItem, prov, inv: list[index]);
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
            DetailNoteScreen(invest: list[index]),)),
            onLongPress: () {
              prov.changePrio(list[index].id!, isPrio);
            }
            
          ),
        );
        
      },
    );
  }
}