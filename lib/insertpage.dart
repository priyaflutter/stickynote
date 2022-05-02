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
  bool issearch = false;
  List<Map>searchlist=[];

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
    double appbarheight =kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight-appbarheight;
    return Scaffold(
      appBar: issearch
          ? AppBar(
              backgroundColor: Color(0x7e0a5163),
              title: TextField(
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              issearch = false;
                            });
                          },
                          icon: Icon(Icons.close))),
                  onChanged: (value) {

                    setState(() {
                      if(value.isNotEmpty)
                        {
                               searchlist=[];
                               for(int i=0;i<mm.length;i++)
                                 {

                                   if(mm[i]['title'].toString().toLowerCase().contains(value.toString().toLowerCase()))

                                     {

                                        searchlist.add(mm[i]);

                                     }
                                 }
                        }
                      else{

                              setState(() {
                                searchlist=mm;
                              });
                      }
                    });

      },)
      )
          : AppBar( actions: [IconButton(onPressed: () {

              setState(() {
                issearch=true;
              });
            
          }, icon: Icon(Icons.search))],
              backgroundColor: Color(0x7e0a5163),
              // centerTitle: true,
              title: Text("Note2"),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: bodyheight * 0.90,
                child: RefreshIndicator(
                  onRefresh: getalldata,
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 2,
                    itemCount:issearch?searchlist.length:mm.length,
                    itemBuilder: (context, index) {
                      Map map=issearch?searchlist[index]:mm[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return editdelete(mm[index], db!);
                            },
                          ));
                        },
                        child: Container(
                            height: bodyheight * 0.32,
                            margin: EdgeInsets.all(bodyheight * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  height: bodyheight * 0.05,
                                  // color: Color(int.parse("${mm[index]['boxcolor']}")),
                                  child: Text(
                                    "${map['title']}",
                                    style:
                                        TextStyle(fontSize: bodyheight * 0.03),
                                  ),
                                ),
                                Container(
                                    height: bodyheight * 0.20,
                                    width: twidth * 0.42,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("images/paper1.jpg"),
                                            fit: BoxFit.fitWidth)),
                                    child: Text("${mm[index]['descri']}")),
                                Container(
                                  height: bodyheight * 0.02,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${mm[index]['date']}",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: bodyheight * 0.01,
                                ),
                                Container(
                                  height: bodyheight * 0.02,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Time :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${mm[index]['time']}",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                )),
          ],
        ),
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
          "Next",
          style: TextStyle(fontSize: bodyheight * 0.03),
        ),
        backgroundColor: Color(0x7e0a5163),
      ),
    );
  }
}
