import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stickynote/editdeletepage.dart';
import 'package:stickynote/main.dart';
import 'package:stickynote/qry.dart';

class insertpage1 extends StatefulWidget {
  // String title1;
  // String descri1;
  // Database database;
  // insertpage1(this.title1, this.descri1, this.database);

  @override
  State<insertpage1> createState() => _insertpage1State();
}

class _insertpage1State extends State<insertpage1> {
  Database? db;
  List<Map> mm = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();
  }

  Future<void> getalldata() async {
    datahelp().Getdatabase().then((value) {
      setState(() {
        db = value;
      });
    });

    datahelp().viewdata(db!).then((map) {
      setState(() {
        mm = map;
      });
    });

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    // double appbarheight =kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x7e0a5163),
        centerTitle: true,
        title: Text("Note2"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
                height: bodyheight * 0.80,
                child: RefreshIndicator(
                  onRefresh: getalldata,
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 2,
                    itemCount: mm.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return editdelete(mm[index], db!);
                            },
                          ));
                        },
                        child: Container(
                            height: bodyheight * 0.35,
                            margin: EdgeInsets.all(bodyheight * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(height: bodyheight*0.05,
                                  child: Text(
                                    "${mm[index]['title']}",
                                    style: TextStyle(fontSize: bodyheight * 0.03),
                                  ),
                                ),
                                Container(
                                    height: bodyheight * 0.29,
                                    width: twidth*0.42,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("images/paper1.jpg"),
                                            fit: BoxFit.fitWidth)),
                                    child: Text("${mm[index]['descri']}"))
                              ],
                            )),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return note();
            },
          ));
        },
        label: Text(
          "Save",
          style: TextStyle(fontSize: bodyheight * 0.03),
        ),
        backgroundColor: Color(0x7e0a5163),
      ),
    );
  }
}
