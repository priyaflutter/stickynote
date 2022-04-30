import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stickynote/editdeletepage.dart';
import 'package:stickynote/insertpage.dart';
import 'package:stickynote/notealter.dart';
import 'package:stickynote/qry.dart';
import 'package:stickynote/secondpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: note(),
  ));
}

bool status = false;

class note extends StatefulWidget {
  @override
  State<note> createState() => _noteState();
}

class _noteState extends State<note> {
  String? box;
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = true;

    getdatabase();
  }

  void getdatabase() {
    datahelp().Getdatabase().then((value) {
      db = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    // double appbarheight =kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return status
        ? Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  Container(
                    height: bodyheight * 0.30,
                    padding: EdgeInsets.all(bodyheight * 0.02),
                    decoration: BoxDecoration(color: Color(0x7e0a5163)),
                    child: Column(
                      children: [
                        Container(
                          height: bodyheight * 0.05,
                          child: Row(
                            children: [
                              Container(
                                  height: bodyheight * 0.04,
                                  child: Icon(
                                    Icons.list,
                                    size: bodyheight * 0.04,
                                  )),
                              SizedBox(
                                width: twidth * 0.04,
                              ),
                              Text(
                                "Sticky Notes",
                                style: TextStyle(fontSize: bodyheight * 0.04),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: bodyheight * 0.15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: bodyheight * 0.12,
                                width: twidth * 0.20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff2a0101),
                                    image: DecorationImage(
                                        image: AssetImage("images/setting.png"),
                                        fit: BoxFit.cover)),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return note();
                                    },
                                  ));
                                  Container(
                                    child: TextField(
                                        controller: a,
                                        decoration: InputDecoration(
                                            labelText: "Type here....")),
                                  );
                                },
                                child: InkWell(
                                  onTap: () {
                                    status = true;
                                    setState(() {
                                      if (status) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return notealter1();
                                          },
                                        ));
                                      } else {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return note();
                                          },
                                        ));
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: bodyheight * 0.15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff744c03),
                                    ),
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: bodyheight * 0.11,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: bodyheight * 0.11,
                                width: twidth * 0.20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff343ba8),
                                    image: DecorationImage(
                                        image:
                                            AssetImage("images/alaram.png"))),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: bodyheight * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Settings",
                                style: TextStyle(fontSize: bodyheight * 0.03),
                              ),
                              Text(
                                "Add Notes",
                                style: TextStyle(fontSize: bodyheight * 0.03),
                              ),
                              Text(
                                "Alram",
                                style: TextStyle(fontSize: bodyheight * 0.03),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Color(0x7e0a5163),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return insertpage1();
                    },
                  ));
                },
                label: Text(
                  "Report",
                  style: TextStyle(fontSize: bodyheight * 0.04),
                )),
          )
        : Center(child: CircularProgressIndicator());
  }

  TextEditingController a = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController descri = TextEditingController();
  Color titlecolor = Colors.white;
}
