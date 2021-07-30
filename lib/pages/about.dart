import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipu_results/widgets/drawer.dart';

import '../colors.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: SecondaryColor,
        title: Text(
          "About",
          style: GoogleFonts.saira(
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: SideNav(),
      body: Container(
        height: size.height,
        color: PrimaryColor,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 25.0),
                        height: 215,
                        // height: size.height * 0.3,
                        decoration: BoxDecoration(
                          color: SecondaryColor,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/bg.jpg",
                              ),
                              fit: BoxFit.fill,
                              scale: 0.5),
                          // color: SecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(200.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                2.0,
                                2.0,
                              ), // shadow direction: bottom right
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 0.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  "IPU Result is a mobile application that provides a result analyzer with subject status and marks is an application tool for displaying the results in a secure way. With this application students can keep track of their progress conveniently and hassle free.The system is intended for the student and teachers. And the privileges that are provided to students are to read his/her result by providing their enrollment number.\n\n This app is developed in Maharaja Surajmal Insitute as a part of my major project",
                                  style: GoogleFonts.saira(
                                      fontSize: 20, color: SecondaryColor),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 50,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
