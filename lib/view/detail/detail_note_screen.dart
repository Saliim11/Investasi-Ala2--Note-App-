import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';

class DetailNoteScreen extends StatelessWidget {
  const DetailNoteScreen({super.key, required this.invest, });
  final Investasi invest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.abu,
      appBar: AppBar(
        backgroundColor: ColorApp.abu,
        title: Teks.biasa("Rincian", fs: 24, fw: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            detailTab("Nama", invest.nama),
            SizedBox(height: 6),
            invest.isInvest? detailTab("Catatan untuk", "Investasi"): detailTab("Catatan untuk", "Hutang"),
            SizedBox(height: 6),
            detailTab("Nominal", "Rp. ${invest.nominal.round()}"),
            SizedBox(height: 6),
            detailTab("Tanggal dimulai", invest.tglMulai),
            SizedBox(height: 6),
            detailTab("Batas waktu", invest.deadline),
            SizedBox(height: 6),
            detailDeskTab("Deskripsi", invest.deskripsi),
          ],
        ),
      ),
    );
  }

  SizedBox detailTab(String judul, String isi) {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Teks.biasa(isi, fs: 20),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Teks.biasa(judul, fs: 24, fw: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  SizedBox detailDeskTab(String judul, String isi) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  alignment: Alignment.topLeft,
                  height: 182,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Teks.biasa(isi, fs: 20),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent, 
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Teks.biasa(judul, fs: 24, fw: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}