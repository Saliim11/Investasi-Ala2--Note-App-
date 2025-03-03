import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/data_list.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/color.dart';
import 'package:investasi_ala_ala/view/view-part/daftar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedPage = 0;

  final TextEditingController _contNama = TextEditingController();
  final TextEditingController _contNominal = TextEditingController();

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  // void _changePriority(int index){
  //   setState(() {
  //     listInvestasi[index].prio = true;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var invest in listInvestasi) {
      if (invest.prio) {
        listPrioritas.add(invest);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Investisi Ala-ala..."),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _changePage(0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _selectedPage == 0 ? biruMuda: abu,
                  ),
                  child: Text("Investasi", style: TextStyle(color: _selectedPage == 0 ? biruTua : abuMuda),),
                ),
              ),
              GestureDetector(
                onTap: () => _changePage(1),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _selectedPage == 1 ? biruMuda : abu,
                  ),
                  child: Text("Hutang", style: TextStyle(color: _selectedPage == 1 ? biruTua : abuMuda),),
                ),
              )
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedPage,
              children: [
            
                // ============================= investasi part ===========================================
                listInvestasi.isEmpty ? Center(child: Text("Udah nda punya simpenan"))
                : tampilanDaftar(0),
            
                // ============================= ngutang part ===========================================
                listInvestasi.isEmpty ? Center(child: Text("Udah gk bakal minus tuh duid"))
                : tampilanDaftar(1),
              ],
            ),
          )
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogTambahDataIH(context);
        },
        backgroundColor: biruMuda,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: biruTua,),
      ),
    );
  }

  Future<dynamic> dialogTambahDataIH(BuildContext context) {
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
              onPressed: () {
                if (selectedCategory == 0) {
                  setState((){
                    listInvestasi.add(
                      Investasi(nama: _contNama.text, nominal: double.parse(_contNominal.text), tglMulai: DateTime.now(), prio: false, isInvest: true)
                    );
                    _contNama.clear();
                    _contNominal.clear();

                  });
                  Navigator.pop(context);
                  
                } else if (selectedCategory == 1) {
                  setState((){
                    listInvestasi.add(
                      Investasi(nama: _contNama.text, nominal: double.parse(_contNominal.text), tglMulai: DateTime.now(), prio: false, isInvest: false)
                    );
                    _contNama.clear();
                    _contNominal.clear();
                  });
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
}