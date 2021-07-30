import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipu_results/widgets/drawer.dart';

import '../colors.dart';

class ResultPage extends StatefulWidget {
  final String sem;
  // ignore: non_constant_identifier_names
  final rec_data, subject_name, credits;

  // ignore: non_constant_identifier_names
  const ResultPage(
      {Key key, this.sem, this.rec_data, this.subject_name, this.credits})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final firestoreInstance = FirebaseFirestore.instance;
  var list_res;
  bool isComplete = false;
  var sub = {}, cred = {};
  var eno;
  double totalMarks = 0,
      maxMarks = 0,
      percentage = 0,
      creditPercent = 0,
      creditTotalMarks = 0,
      totalCredit = 0,
      maxCreditMarks = 0;

  void resList() {
    // print(cred);
    list_res = [];
    totalMarks = 0;
    maxMarks = 0;
    percentage = 0;
    creditTotalMarks = 0;
    totalCredit = 0;
    maxCreditMarks = 0;
    creditPercent = 0;
    for (var i in widget.rec_data.keys) {
      if (i != "Enrollment Number" && i != "Name" && widget.credits != {}) {
        totalMarks = totalMarks + widget.rec_data[i]["Total"];
        maxMarks += 100;
        list_res.add(i);
        // creditTotalMarks =
        //     creditTotalMarks + (widget.rec_data[i]["Total"] * cred[i]);
        // totalCredit += cred[i];
        // maxCreditMarks += (100 * cred[i]);

        print("widget.subject_name[i]: ${widget.subject_name[i]}");
        totalCredit += widget.credits[i];
        creditTotalMarks = creditTotalMarks +
            (widget.rec_data[i]["Total"] * widget.credits[i]);
        maxCreditMarks += 100 * widget.credits[i];
      }
      if (i == "Enrollment Number") {
        eno = widget.rec_data[i];
      }
    }
    print("Total Marks = $totalMarks");
    print(widget.subject_name.length);

    percentage = totalMarks / (maxMarks / 100);
    creditPercent = creditTotalMarks / totalCredit;
    //print(list_res);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resList();
  }

  @override
  Widget build(BuildContext context) {
    //resList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SecondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "${widget.sem}",
          style: GoogleFonts.saira(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: SideNav(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.subject_name.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: PrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "${widget.subject_name[list_res[index]]} (${widget.credits[list_res[index]]})",
                                style: GoogleFonts.saira(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: SecondaryColor),
                                minFontSize: 10.0,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Internals: ",
                                      style: GoogleFonts.saira(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.rec_data[list_res[index]]["Internal"]}",
                                      style: GoogleFonts.saira(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Externals: ",
                                      style: GoogleFonts.saira(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.rec_data[list_res[index]]["External"]}",
                                      style: GoogleFonts.saira(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total: ",
                                      style: GoogleFonts.saira(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.rec_data[list_res[index]]["Total"]}",
                                      style: GoogleFonts.saira(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.4,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                color: SecondaryColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                        Text(
                          "$totalMarks/$maxMarks",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: PrimaryColor,
                      height: 1.4,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Percentage:",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                        Text(
                          "${percentage.toStringAsFixed(3)} %",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: PrimaryColor,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Credit Marks:",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                        Text(
                          "$creditTotalMarks/$maxCreditMarks",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: .0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Divider(
                      color: PrimaryColor,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Credit percentage:",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                        Text(
                          "${creditPercent.toStringAsFixed(3)} %",
                          style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: .0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  ////////////////////////////////////for graph/////////////////////////////////////
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
