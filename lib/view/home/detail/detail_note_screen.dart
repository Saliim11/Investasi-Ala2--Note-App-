import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';

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
        title: Teks.spesial("A.N ${widget.invest.nama}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(child: Teks.spesial("Nominal :")),
                Expanded(child: Teks.spesial("${widget.invest.nominal}")),
              ],
            ),
            Row(
              children: [
                Expanded(child: Teks.spesial("Deskripsi :")),
                Expanded(child: Teks.spesial(widget.invest.deskripsi)),
              ],
            ),
            Row(
              children: [
                Expanded(child: Teks.spesial("Tanggal transaksi :")),
                Expanded(child: Teks.spesial(widget.invest.tglMulai)),
              ],
            ),
            Row(
              children: [
                Expanded(child: Teks.spesial("Deadline :")),
                Expanded(child: Teks.spesial(widget.invest.deadline))
              ],
            ),
          ],
        ),
      ),
    );
  }
}