import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stickynote/insertpage.dart';
import 'package:stickynote/main.dart';
import 'package:stickynote/qry.dart';

class notealter1 extends StatefulWidget {
  const notealter1({Key? key}) : super(key: key);

  @override
  State<notealter1> createState() => _notealter1State();
}

class _notealter1State extends State<notealter1> {
  String? box;
  Database? db;
  String boxcolor = "0x7e0a5163";
  String date = "";
  String time = "";
  // String color1="";




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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  onTap: () {},
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
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    builder: (context) {
                                      return Container(
                                        height: bodyheight * 0.20,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FlatButton.icon(
                                                onPressed: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2030),
                                                    builder: (context, child) {
                                                      return Theme(
                                                          data:
                                                              ThemeData.light(),
                                                          child: child!);
                                                    },
                                                  ).then((value) {
                                                      setState(() {
                                                        date =
                                                            "${value!.day.toString()}/${value!.month.toString()}/${value!.year.toString()}";
                                                      });
                                                  });
                                                  
                                                },
                                                icon: Icon(Icons.date_range),
                                                label: Text("${date}")),


                                            FlatButton.icon(
                                                onPressed: () {

                                                  showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay(
                                                        hour: 12, minute: 00),
                                                    builder: (context, child) {
                                                      return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      false),
                                                          child: child!);

                                                    },
                                                  ).then((value) {
                                                    
                                                    setState(() {
                                                      // time = "${value!.hour.toString()}:${value!.minute.toString()}";
                                                      time="${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(value!.hour.toString()+':'+value!.minute.toString()+':00'))}";
                                                    });
                                                  });

                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text("${time}")),
                                          ],
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                },
                                child: Container(
                                  height: bodyheight * 0.11,
                                  width: twidth * 0.20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff343ba8),
                                      image: DecorationImage(
                                          image:
                                              AssetImage("images/alaram.png"))),
                                ),
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
                  Container(
                    height: bodyheight * 0.45,
                    width: twidth*0.70,
                    margin: EdgeInsets.all(bodyheight * 0.05),
                    decoration: BoxDecoration(
                        // color: Color(0x7e0a5163),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Column(
                      children: [
                        Container(
                          height: bodyheight * 0.10,
                          width: twidth * 0.70,
                          decoration: BoxDecoration(color: Color(int.parse(boxcolor))),
                          child: TextField(
                            controller: title,
                            toolbarOptions: ToolbarOptions(copy: true,cut: true,paste: true,selectAll: true),
                            decoration: InputDecoration(
                              labelText: "Title",
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 20),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                        Container(
                          height: bodyheight * 0.29,
                          width: twidth * 0.70,
                          decoration: BoxDecoration(
                              color: Color(0x7D1616FF),
                              image: DecorationImage(
                                  image: AssetImage("images/paper1.jpg"),
                                  fit: BoxFit.fitWidth)),
                          child: TextField(
                            maxLines: 20,
                            toolbarOptions: ToolbarOptions(copy: true,cut: true,paste: true,selectAll: true),
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
                        Center(
                          child: Container(height: bodyheight*0.05,
                            child: Row(
                              children: [ Text(
                                "Date : ",style: TextStyle(fontWeight:FontWeight.bold ),
                              ), Text(
                                "${date}",
                              ),
                                Text(
                                  "Time : ",style: TextStyle(fontWeight:FontWeight.bold ),
                                ),
                                Text(
                                  "${time}",
                                )],
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
                      height: bodyheight * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                               String title1 = title.text;
                               String  descri1 = descri.text;
                               String date1=date.toString();
                               String time1=time.toString();
                               // String color1=color.toString();
                              datahelp().inserdata(title1, descri1, db!,date1,time1);

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.INFO,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Suceess',
                                desc: 'Note Save Successfully....',
                                showCloseIcon: true,
                                headerAnimationLoop: false,
                                closeIcon:
                                    Icon(Icons.close_fullscreen_outlined),
                                btnCancelOnPress: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                },
                                btnOkOnPress: () {
                                  Icons.check_circle;
                                },
                              )..show();

                              // Fluttertoast.showToast(
                              //     msg: "Note Save Succesfully",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0);

                              Future.delayed(Duration(seconds: 2))
                                  .then((value) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return insertpage1();
                                  },
                                ));
                              });
                            },
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0x7e0a5163))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                builder: (context) {
                                  return Container(
                                    height: bodyheight * 0.30,
                                    child: GridView.builder(
                                      itemCount: mycolor1.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 8),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            boxcolor =mycolor1[index].toString();
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            color: Color(mycolor1[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                context: context,
                              );

                              setState(() {});
                            },
                            child: Text(
                              "Decoration",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0x7e0a5163))),
                          ),

                          ElevatedButton(onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                      return insertpage1();
                            },));
                          }, child: Text("Next", style:
                              TextStyle(color: Colors.black, fontSize: 20),
                          ),style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0x7e0a5163))),
                          )
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.pushReplacement(context,
                          //         MaterialPageRoute(
                          //       builder: (context) {
                          //         return insertpage1();
                          //       },
                          //     ));
                          //   },
                          //   child: Text(
                          //     "Report",
                          //     style:
                          //         TextStyle(color: Colors.black, fontSize: 20),
                          //   ),
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all(
                          //           Color(0x7e0a5163))),
                          // ),
                        ],
                      ))
                ],
              )),
            ),
          )
        : Center(child: CircularProgressIndicator());
    ;
  }

  TextEditingController a = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController descri = TextEditingController();

  Color titlecolor = Colors.white;

  String ans = "";

  List mycolor = [
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

  List<int> mycolor1 = [
    0x7e0a5163,
    0x36F4A2FF,
    0x5336F4FF,
    0x36F4A8FF,
    0x9B36F4FF,
    0x36F4E4FF,
    0x6F8946FF
  ];

  // List<String> mycolor1 = [
  //   "0x7e0a5163",
  //   "0x36F4A2FF",
  //   "0x5336F4FF",
  //   "0x36F4A8FF",
  //   "0x9B36F4FF",
  //   "0x36F4E4FF",
  //   "0x6F8946FF"
  // ];
}
