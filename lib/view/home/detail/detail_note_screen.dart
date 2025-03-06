import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/model/investasi.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({super.key, required this.invest, });
  final Investasi invest;

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed A.N ${widget.invest.nama}"),
      ),
      body: Column(
        children: [
          Text("Nominal : ${widget.invest.nominal}"),
          widget.invest.deskripsi == null ? Text("Deskripsi tidak ada"): Text("Deskripsi ${widget.invest.deskripsi}"),
          Text("Tanggal transaksi : ${widget.invest.tglMulai}"),
          widget.invest.deadline == null ? Text("Tidak ada waktu deadline") : Text("Deadline : ${widget.invest.deadline}")
        ],
      ),
    );
  }
}