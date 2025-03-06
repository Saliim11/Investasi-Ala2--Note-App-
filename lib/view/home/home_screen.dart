import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/data/data_list.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/view/home/widgets/daftar.dart';

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

  void _changePriority(int index){
    setState(() {
      listInvestasi[index].prio = true;
    });
  }
  List<Investasi> listPrioritas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPrioritas = listInvestasi.where((element) => element.prio == true).toList();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Semua Catatan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(Icons.search, color: Colors.black,),
                        ),
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(Icons.history, color: Colors.black,),
                        ),
                      ],
                    )
                  ],
                ),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount: listPrioritas.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5
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
                            teksMainScreen("Save money to ${listPrioritas[index].nama}", fw: FontWeight.w700, fs: 12),
                            teksMainScreen("Deadline: ${listPrioritas[index].deadline}", fw: FontWeight.w200, fs: 10),
                            CircleAvatar(
                              backgroundColor: ColorApp.abu,
                              maxRadius: 10,
                              minRadius: 10,
                              child: Icon(Icons.arrow_forward),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(10),
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height * 0.2,
      //       child: Card(
      //       ),
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         GestureDetector(
      //           onTap: () => _changePage(0),
      //           child: Container(
      //             padding: EdgeInsets.all(10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(20),
      //               color: _selectedPage == 0 ? biruMuda: abu,
      //             ),
      //             child: Text("Investasi", style: TextStyle(color: _selectedPage == 0 ? biruTua : abuMuda),),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () => _changePage(1),
      //           child: Container(
      //             padding: EdgeInsets.all(10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(20),
      //               color: _selectedPage == 1 ? biruMuda : abu,
      //             ),
      //             child: Text("Hutang", style: TextStyle(color: _selectedPage == 1 ? biruTua : abuMuda),),
      //           ),
      //         )
      //       ],
      //     ),
      //     Expanded(
      //       child: IndexedStack(
      //         index: _selectedPage,
      //         children: [
            
      //           // ============================= investasi part ===========================================
      //           listInvestasi.isEmpty ? Center(child: Text("Udah nda punya simpenan"))
      //           : tampilanDaftar(0),
            
      //           // ============================= ngutang part ===========================================
      //           listInvestasi.isEmpty ? Center(child: Text("Udah gk bakal minus tuh duid"))
      //           : tampilanDaftar(1),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogTambahDataIH(context);
        },
        backgroundColor: Colors.white,
        shape: CircleBorder(side: BorderSide(width: 1)),
        child: Icon(Icons.add, color: Colors.black, size: 40,),
      ),
    );
  }

  Text teksMainScreen(String text, {FontWeight? fw, double? fs}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fw,
        fontSize: fs
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