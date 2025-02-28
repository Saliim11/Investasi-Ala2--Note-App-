// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Hutang {
  final String nama;
  final double nominal;
  final DateTime tglMulai;
  final bool prio;
  Hutang({
    required this.nama,
    required this.nominal,
    required this.tglMulai,
    required this.prio,
  });

  Hutang copyWith({
    String? nama,
    double? nominal,
    DateTime? tglMulai,
    bool? prio,
  }) {
    return Hutang(
      nama: nama ?? this.nama,
      nominal: nominal ?? this.nominal,
      tglMulai: tglMulai ?? this.tglMulai,
      prio: prio ?? this.prio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'nominal': nominal,
      'tglMulai': tglMulai.millisecondsSinceEpoch,
      'prio': prio,
    };
  }

  factory Hutang.fromMap(Map<String, dynamic> map) {
    return Hutang(
      nama: map['nama'] as String,
      nominal: map['nominal'] as double,
      tglMulai: DateTime.fromMillisecondsSinceEpoch(map['tglMulai'] as int),
      prio: map['prio'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hutang.fromJson(String source) => Hutang.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hutang(nama: $nama, nominal: $nominal, tglMulai: $tglMulai, prio: $prio)';
  }

  @override
  bool operator ==(covariant Hutang other) {
    if (identical(this, other)) return true;
  
    return 
      other.nama == nama &&
      other.nominal == nominal &&
      other.tglMulai == tglMulai &&
      other.prio == prio;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
      nominal.hashCode ^
      tglMulai.hashCode ^
      prio.hashCode;
  }
}
