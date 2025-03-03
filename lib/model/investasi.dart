// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Investasi {
  final String nama;
  final double nominal;
  final String? deskripsi;
  final DateTime tglMulai;
  final DateTime? deadline;
  final bool prio;
  Investasi({
    required this.nama,
    required this.nominal,
    this.deskripsi,
    required this.tglMulai,
    this.deadline,
    required this.prio,
  });

  Investasi copyWith({
    String? nama,
    double? nominal,
    String? deskripsi,
    DateTime? tglMulai,
    DateTime? deadline,
    bool? prio,
  }) {
    return Investasi(
      nama: nama ?? this.nama,
      nominal: nominal ?? this.nominal,
      deskripsi: deskripsi ?? this.deskripsi,
      tglMulai: tglMulai ?? this.tglMulai,
      deadline: deadline ?? this.deadline,
      prio: prio ?? this.prio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'nominal': nominal,
      'deskripsi': deskripsi,
      'tglMulai': tglMulai.millisecondsSinceEpoch,
      'deadline': deadline?.millisecondsSinceEpoch,
      'prio': prio,
    };
  }

  factory Investasi.fromMap(Map<String, dynamic> map) {
    return Investasi(
      nama: map['nama'] as String,
      nominal: map['nominal'] as double,
      deskripsi: map['deskripsi'] != null ? map['deskripsi'] as String : null,
      tglMulai: DateTime.fromMillisecondsSinceEpoch(map['tglMulai'] as int),
      deadline: map['deadline'] != null ? DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int) : null,
      prio: map['prio'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Investasi.fromJson(String source) => Investasi.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Investasi(nama: $nama, nominal: $nominal, deskripsi: $deskripsi, tglMulai: $tglMulai, deadline: $deadline, prio: $prio)';
  }

  @override
  bool operator ==(covariant Investasi other) {
    if (identical(this, other)) return true;
  
    return 
      other.nama == nama &&
      other.nominal == nominal &&
      other.deskripsi == deskripsi &&
      other.tglMulai == tglMulai &&
      other.deadline == deadline &&
      other.prio == prio;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
      nominal.hashCode ^
      deskripsi.hashCode ^
      tglMulai.hashCode ^
      deadline.hashCode ^
      prio.hashCode;
  }
}
