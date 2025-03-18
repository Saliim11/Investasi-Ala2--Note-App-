import 'package:flutter/foundation.dart';
import 'package:investasi_ala_ala/database/db_helper.dart';
import 'package:investasi_ala_ala/model/investasi.dart';

class InvestasiProvider with ChangeNotifier{
  DbHelper db = DbHelper();
  int _isInvestTab = 0;
  List<Investasi> _listInvestasi = [];

  int get isInvestTab => _isInvestTab;
  List<Investasi> get listInvestasi => _listInvestasi;

  void changeTab(int value){
    _isInvestTab = value;
    notifyListeners();
  }

  void getListInvestasi()async{
    _listInvestasi = await db.getInvestasi();
    notifyListeners();
  }
}