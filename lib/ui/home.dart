import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penjualan_voucher/ui/inputpenjualan.dart';
import 'package:penjualan_voucher/models/penjualan.dart';
import 'package:penjualan_voucher/helpers/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Penjualan> penjualanList;

  @override
  Widget build(BuildContext context) {
    if (penjualanList == null) {
      penjualanList = List<Penjualan>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan  Voucher'),
        leading: Icon(Icons.wifi),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Input  Penjualan',
        onPressed: () async {
          var penjualan = await navigateToEntryForm(context, null);
          if (penjualan != null) addPenjualan(penjualan);
        },
      ),
    );
  }

  Future<Penjualan> navigateToEntryForm(
      BuildContext context, Penjualan penjualan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return InputPenjualan(penjualan);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.penjualanList[index].getName,
              style: textStyle,
            ),
            subtitle: Row(
              children: <Widget>[
                Text(this.penjualanList[index].getTanggal),
                Text(
                  "  |  Rp.  " + this.penjualanList[index].getJumlah,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deletePenjualan(penjualanList[index]);
                Fluttertoast.showToast(
                    msg: "Daftar Telah Dihapus.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
            onTap: () async {
              var penjualan =
                  await navigateToEntryForm(context, this.penjualanList[index]);

              if (penjualan != null) editPenjualan(penjualan);
            },
          ),
        );
      },
    );
  }

  void addPenjualan(Penjualan object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editPenjualan(Penjualan object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
      print("ini  editPenjualan  RESULT  $result");
    }
  }

  void deletePenjualan(Penjualan object) async {
    int result = await dbHelper.delete(object.getId);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((datatabase) {
      Future<List<Penjualan>> penjualanListFuture = dbHelper.getPenjualanList();
      penjualanListFuture.then((penjualanList) {
        setState(() {
          this.penjualanList = penjualanList;
          this.count = penjualanList.length;
        });
      });
    });
  }
}
