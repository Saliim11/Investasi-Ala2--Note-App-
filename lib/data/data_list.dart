import 'package:investasi_ala_ala/model/hutang.dart';
import 'package:investasi_ala_ala/model/investasi.dart';

List<Investasi> listInvestasi = [
  Investasi(nama: "Dummy Investasi", nominal: 80000.0, tglMulai: DateTime.now(), prio: false),
  Investasi(nama: "Dummy Investasi2", nominal: 100000.0, tglMulai: DateTime.now(), prio: true),
];

List<Hutang> listHutang = [
  Hutang(nama: "Dummy Hutang", nominal: 100000, tglMulai: DateTime.now(), prio: true),
  Hutang(nama: "Dummy Hutang2", nominal: 8000, tglMulai: DateTime.now(), prio: false),
];

List<dynamic> listPrioritas = [];