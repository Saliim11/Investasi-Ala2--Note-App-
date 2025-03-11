// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Investasi {
  final int? id;
  final String nama;
  final double nominal;
  final String deskripsi;
  final String tglMulai;
  final String deadline;
  final bool isPrio;
  final bool isInvest;
  Investasi({
    this.id,
    required this.nama,
    required this.nominal,
    required this.deskripsi,
    required this.tglMulai,
    required this.deadline,
    required this.isPrio,
    required this.isInvest,
  });
  

  Investasi copyWith({
    int? id,
    String? nama,
    double? nominal,
    String? deskripsi,
    String? tglMulai,
    String? deadline,
    bool? isPrio,
    bool? isInvest,
  }) {
    return Investasi(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nominal: nominal ?? this.nominal,
      deskripsi: deskripsi ?? this.deskripsi,
      tglMulai: tglMulai ?? this.tglMulai,
      deadline: deadline ?? this.deadline,
      isPrio: isPrio ?? this.isPrio,
      isInvest: isInvest ?? this.isInvest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'nominal': nominal,
      'deskripsi': deskripsi,
      'tglMulai': tglMulai,
      'deadline': deadline,
      'isPrio': isPrio,
      'isInvest': isInvest,
    };
  }

  factory Investasi.fromMap(Map<String, dynamic> map) {
    return Investasi(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      nominal: map['nominal'] as double,
      deskripsi: map['deskripsi'] as String,
      tglMulai: map['tglMulai'] as String,
      deadline: map['deadline'] as String,
      isPrio: map['isPrio'] as bool,
      isInvest: map['isInvest'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Investasi.fromJson(String source) => Investasi.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Investasi(id: $id, nama: $nama, nominal: $nominal, deskripsi: $deskripsi, tglMulai: $tglMulai, deadline: $deadline, isPrio: $isPrio, isInvest: $isInvest)';
  }

  @override
  bool operator ==(covariant Investasi other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama &&
      other.nominal == nominal &&
      other.deskripsi == deskripsi &&
      other.tglMulai == tglMulai &&
      other.deadline == deadline &&
      other.isPrio == isPrio &&
      other.isInvest == isInvest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      nominal.hashCode ^
      deskripsi.hashCode ^
      tglMulai.hashCode ^
      deadline.hashCode ^
      isPrio.hashCode ^
      isInvest.hashCode;
  }
}
