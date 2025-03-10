import 'package:intl/intl.dart';
import 'package:investasi_ala_ala/model/investasi.dart';

String tgl = DateFormat('dd MMM yyyy').format(DateTime.now());
List<Investasi> listInvestasi = [
  Investasi(nama: "Dummy Hutang", nominal: 100000, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: true, isInvest: false),
  Investasi(nama: "Dummy Hutang2", nominal: 8000, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: false, isInvest: false),
  Investasi(nama: "Dummy Hutang3", nominal: 100000, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: true, isInvest: false),
  Investasi(nama: "Dummy Investasi", nominal: 80000.0, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: false, isInvest: true),
  Investasi(nama: "Dummy Investasi2", nominal: 100000.0, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: true, isInvest: true),
  Investasi(nama: "Dummy Investasi3", nominal: 100000.0, deskripsi: "", tglMulai: tgl, deadline: tgl, isPrio: true, isInvest: true),
];


// List<Investasi> listInvestasi = [];