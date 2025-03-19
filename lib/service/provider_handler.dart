import 'package:flutter/foundation.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';

class InvestasiProvider with ChangeNotifier{
  DbHelper db = DbHelper();

  int _isInvestTab = 0;
  List<Investasi> _listInvestasi = [];
  List<Investasi> _listPrioritas = [];

  int get isInvestTab => _isInvestTab;
  List<Investasi> get listInvestasi => _listInvestasi;
  List<Investasi> get listPrioritas => _listPrioritas;

  void changeTab(int value){
    _isInvestTab = value;
    notifyListeners();
  }

  void getListInvestasi()async{
    _listInvestasi = await db.getInvestasi();
    _listPrioritas = _listInvestasi.where((element) => element.isPrio == true).toList();
    notifyListeners();
  }

  void addItemInvestasi(Investasi inv){
    db.insertInvestasi(inv);
    getListInvestasi();
  }

  void editInvestasi(int id, String nama, double nominal, bool isInvest, String tglMulai, String deadline, String deskripsi){
    db.updateInvest(id, nama: nama, nominal: nominal, isInvest: isInvest, tglMulai: tglMulai, deadline: deadline, deskripsi: deskripsi);
    getListInvestasi();
  }

  void changePrio(int id, bool isPrio) {
    db.updatePrio(id, isPrio);
    getListInvestasi();
  }

  void deleteItem(int id) {
    db.deleteInvestasi(id);
    getListInvestasi();
  }
}