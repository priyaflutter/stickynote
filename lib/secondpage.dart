import 'package:flutter/material.dart';
import 'package:stickynote/insertpage.dart';
import 'package:stickynote/main.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}






// note use this page

class _secondState extends State<second> {

  bool status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     image=List.filled(color.length, "");
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: bodyheight * 0.30,
                padding: EdgeInsets.all(0.02),
                decoration: BoxDecoration(color: Color(0x7e0a5163)),
                child: Column(
                  children: [
                    SizedBox(
                      height: bodyheight * 0.15,
                    ),
                    TextField(
                        controller: name,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Category name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: bodyheight * 0.03,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff070202), width: 2)),
                        )),
                  ],
                ),
              ),
              Container(
                  height: bodyheight * 0.60,
                  child: GridView.builder(
                    itemCount: color.length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {

                           
                              setState(() {
                                image[index]="images/tick.png";
                              });
                              setState(() {
                                     
                              });


                        },
                        child: Container(
                          height: bodyheight * 0.05,
                          width: twidth * 0.05,
                          margin: EdgeInsets.all(bodyheight * 0.01),
                          decoration: BoxDecoration(color: color[index],image: DecorationImage(image: AssetImage(
                              image[index]))),
                        ),
                      );
                    },
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      String name1 = name.text;
                      String change=color.length.toString();
                      return  insertpage1();
                    },
                  ));
                },
                child: Container(
                  height: bodyheight * 0.08,
                  decoration: BoxDecoration(color: Color(0x7e0a5163)),
                  child: Center(
                      child: Text(
                    "OK",
                    style: TextStyle(fontSize: bodyheight * 0.03),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();

  List color = [
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.lightGreen,
    Colors.pink,
    Colors.grey,
    Colors.orangeAccent,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.yellow,
    Colors.teal,
    Colors.brown,
  ];

  List image=[];

  TextEditingController tick = TextEditingController();





}
