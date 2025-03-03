import 'package:flutter/material.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({super.key, required this.nama, required this.nominal, this.deskripsi, required this.tglMulai, this.deadline});
  final String nama;
  final double nominal;
  final String? deskripsi;
  final DateTime tglMulai;
  final DateTime? deadline;

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed A.N ${widget.nama}"),
      ),
      body: Column(
        children: [
          Text("Nominal : ${widget.nominal}"),
          widget.deskripsi == null ? Text("Deskripsi tidak ada"): Text("Deskripsi ${widget.deskripsi}"),
          Text("Tanggal transaksi : ${widget.tglMulai}"),
          widget.deadline == null ? Text("Tidak ada waktu deadline") : Text("Deadline : ${widget.deadline}")
        ],
      ),
    );
  }
}