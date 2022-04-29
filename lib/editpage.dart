import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stickynote/editdeletepage.dart';
import 'package:stickynote/insertpage.dart';
import 'package:stickynote/main.dart';
import 'package:stickynote/notealter.dart';
import 'package:stickynote/qry.dart';


class edit extends StatefulWidget {


  Map mm;
  Database database;
  edit(this.mm,this.database);


  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {

  int? id;
  Database? db;
  List<Map> mm=[];
  List image=[];

  Color cardcolor=Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title2=widget.mm['title'];
    title.text=title2;
    String descri2=widget.mm['descri'];
    descri.text=descri2;
    id=widget.mm['id'];

    getalldata();

    image=List.filled(color.length,"");

  }
  Future<void> getalldata() async {
    datahelp().Getdatabase().then((value) {
      setState(() {
        db = value;
      });

      datahelp().viewdata(db!).then((listofmap) {
        setState(() {
          mm = listofmap;
        });
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
        title: Text("Notes4"),
      ),
      body: SingleChildScrollView(physics: NeverScrollableScrollPhysics(),
        child: Container(height: bodyheight*0.95,
          child: Column(
            children: [
              SizedBox(height: bodyheight*0.06,),
              Container(
                height: bodyheight * 0.40,
                margin: EdgeInsets.all(bodyheight * 0.05),
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black, width: 2)),
                child: Column(
                  children: [
                    Container(
                      height: bodyheight * 0.08,
                      width: twidth * 0.70,
                      decoration: BoxDecoration(color:cardcolor),
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle:
                          TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.31,
                      width: twidth * 0.70,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("images/paper1.jpg"),
                              fit: BoxFit.fitWidth)),
                      child: TextField(
                        maxLines: 20,
                        controller: descri,
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: bodyheight * 0.05,
              ),
              Container(
                  height: bodyheight * 0.15,
                  child: ListView.builder(
                    itemCount: color.length,
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {

                          image=List.filled(color.length, "");
                          image[index] = "images/tick.png";


                          cardcolor = color[index];

                          setState(() {});
                        },
                        child: Container(
                          height: bodyheight * 0.05,
                          width: twidth * 0.20,
                          margin: EdgeInsets.all(bodyheight * 0.01),
                          decoration: BoxDecoration(
                              color: color[index],
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: color[index], width: 2),
                              image: DecorationImage(
                                  image: AssetImage(image[index]),fit: BoxFit.cover)),
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: bodyheight * 0.05,
              ),
              Container(
                height: bodyheight * 0.10,
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // InkWell(onTap: () {
                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    //     return edit(widget.mm,widget.database);
                    //
                    //   },)) ;
                    // },
                    //   child: Container(height: bodyheight*0.06,
                    //       width: twidth*0.25,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           color: Color(0x7e0a5163)),
                    //       child: Center(
                    //         child: Text(
                    //           "Edit",
                    //           style: TextStyle(fontSize: bodyheight * 0.03),
                    //         ),
                    //       )),
                    // ),


                    InkWell( onTap: () {


                        datahelp().deletedata(db!,id!);
                        setState(() {

                        });

                        Future.delayed(Duration(seconds: 2))
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Note Delete Succesfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return insertpage1();
                                },
                              ));
                        });

                    },
                      child: Container(height: bodyheight*0.06,
                          width: twidth*0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x7e0a5163)),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(fontSize: bodyheight * 0.03),
                            ),
                          )),
                    ),
                    InkWell( onTap: () {

                      String title1=title.text;
                      String descri1=descri.text;

                      datahelp().editdata(title1,descri1,widget.database,id!);

                      Fluttertoast.showToast(
                          msg: "Update Save Succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      Future.delayed(Duration(seconds: 2)).then((value) {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return insertpage1();
                        },));
                        
                      });

                    },
                      child: Container(height: bodyheight*0.06,
                          width: twidth*0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0x7e0a5163)),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: bodyheight * 0.03),
                            ),
                          )),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController title = TextEditingController();
  TextEditingController descri = TextEditingController();


  List color = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.pink,
    Colors.deepOrange,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.black,
    Colors.lightGreenAccent,
    Colors.amberAccent,
    Colors.white,
    Colors.pinkAccent,
    Colors.deepPurpleAccent,
    Colors.cyanAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.black26,
    Colors.limeAccent,
    Colors.lightBlue,
    Colors.indigo,
    Colors.redAccent,
    Colors.lime,
    Colors.brown,
    Colors.indigoAccent,
  ];

}
