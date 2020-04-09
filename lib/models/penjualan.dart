class Penjualan {
  int _id;
  String _name;
  String _keterangan;
  String _jumlah;
  String _tanggal;
  Penjualan(this._name, this._keterangan, this._jumlah, this._tanggal);
  Penjualan.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'].toString();
    this._keterangan = map['keterangan'].toString();
    this._jumlah = map['jumlah'].toString();
    this._tanggal = map['tanggal'].toString();
  }

  int get getId => _id;
  String get getName => _name;
  String get getKeterangan => _keterangan;
  String get getJumlah => _jumlah;
  String get getTanggal => _tanggal;

  set setName(String value) {
    _name = value;
  }

  set setKeterangan(String value) {
    _keterangan = value;
  }

  set setJumlah(String value) {
    _jumlah = value;
  }

  set setTanggal(String value) {
    _tanggal = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = getId;
    map['name'] = getName;
    map['keterangan'] = getKeterangan;
    map['jumlah'] = getJumlah;
    map['tanggal'] = getTanggal;
    return map;
  }
}
