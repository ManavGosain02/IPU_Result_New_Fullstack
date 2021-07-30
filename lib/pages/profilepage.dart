import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipu_results/colors.dart';
import 'package:ipu_results/pages/resultpage.dart';
import 'package:ipu_results/widgets/drawer.dart';

class ProfilePage extends StatefulWidget {
  final String enroll, name;
  // ignore: non_constant_identifier_names

  ProfilePage({Key key, this.enroll, this.name}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String current_sem = "Sem 1", msg = " ";
  var data = new SplayTreeMap(), subject = {}, credit = {};
  bool isLoading = false, isError = false;
  final firestoreInstance = FirebaseFirestore.instance;
  final clg = {
    "MSI": "Maharaja Surajmal Institute",
    "AIT": "Ambedkar Institute Of Technology",
    "BITM": "Bls Institute Of Technology & Management",
    "BMIET": "Bm Institute Of Engineering & Technology",
    "COMM-IT": " Comm-It Career Academy (Minority Educational Institution)",
    'CPJCHS': " Chanderprabhu Jain College Of Higher Studies And School Of Law",
    'DTC': "Delhi Technical Campus, Greater Noida",
    'FITM': " Fairfield Institute Of Management & Technology",
    'IIT': "Integrated Institute Of Technology",
    'IITM': " Institute Of Information Technology And Management",
    'IITM2': " Institute Of Innovation In Technology & Management",
    'JEMTEC': " Jims Engineering Management Technical Campus, Greater Noida",
    'JIMS': " Jagan Institute Of Management Studies, Rohini",
    'JIMS-VK': " Jagannath International Management School, Vasant Kunj",
    'KCCILHE': "Kcc Institute Of Legal And Higher Education",
    'KIHEAT': "Kamal Institute Of Higher Education And Advanced Technology",
    'KIRAS': " Kalka Institute For Research & Advanced Studies",
    'RCIT': " R C Institute Of Technology",
    'SCCTM': " Sirifort College Of Computer Technology & Management",
    'SGIT': " Sgit School Of Management, Ghaziabad",
    'SGTBIMIT':
        " Sri Guru Tegh Bahadur Institute Of Management And Information Technology",
    'TIHE': " Trinity Institute Of Higher Education",
    'TIPS': " Trinity Institute Of Professional Studies",
    'UCE': " United College Of Education",
    'VIPS': " Vivekananda Institute Of Professional Studies"
  };
  final clg_code = {
    "248": 'AIT',
    "205": 'BITM',
    "-3": 'BMIET',
    "120": 'COMM-IT',
    "241": 'CPJCHS',
    "215": 'CPJCHS',
    "0": 'DTC',
    "901": 'FITM',
    "514": 'FITM',
    "501": 'IIT',
    "211": 'IITM',
    "137": 'IITM',
    "903": 'IITM2',
    "244": 'IITM2',
    "255": 'JEMTEC',
    "140": 'JIMS',
    "504": 'JIMS',
    "142": 'JIMS-VK',
    "214": 'JIMS-VK',
    '-1': 'KCCILHE',
    '967': 'KIHEAT',
    '144': 'KIRAS',
    '149': 'MSI',
    '212': 'MSI',
    '158': 'RCIT',
    '243': 'SCCTM',
    '167': 'SCCTM',
    '247': 'SGIT',
    '902': 'SGTBIMIT',
    '172': 'TIHE',
    '206': 'TIPS',
    '240': 'TIPS',
    '-2': 'UCE',
    '177': 'VIPS',
    '298': 'VIPS'
  };
  final courses = {
    "020": "Bachelor of Computer Application (B.C.A.)",
    "027": "	Bachelor of Technology (B. Tech.)",
    "017": "Bachelor of Business Administration (B.B.A.)"
  };

  Future<void> goToResult(BuildContext context) async {
    var cy = widget.enroll.toString().substring(7),
        cc = widget.enroll.toString().substring(3, 6),
        courseCode = widget.enroll.toString().substring(6, 9);
    print(cy);
    subject = {};
    credit = {};
    setState(() {
      isLoading = true;
    });
    if (current_sem != "Overall") {
      await firestoreInstance
          .collection("Result")
          .doc(cy)
          .collection(cc)
          .doc(current_sem)
          .get()
          .then((querySnapshot) async {
        querySnapshot.data().forEach((key, value) {
          if (key == "${int.parse(widget.enroll)}") {
            print("Value: $value");
            setState(() {
              data = new SplayTreeMap<String, dynamic>.from(value[0]);
            });
          }
        });
        for (var k in data.keys) {
          if (k.length == 5) {
            await firestoreInstance
                .collection("Subject")
                .doc(courseCode)
                .collection(current_sem)
                .doc(k)
                .get()
                .then((value) {
              setState(() {
                subject[k] = value.data()["Paper"];
                credit[k] = value.data()["Credit"];
              });
            });
          }
        }
      }).onError((error, stackTrace) {
        setState(() {
          print(error);
          isLoading = false;
          isError = true;
          msg = "RESULT NOT DECLARED YET !!!";
        });
      }).whenComplete(() async {
        //print(subject);

        try {
          if (data != {} && credit != {} && isLoading == true) {
            isError = false;
            print("gya h isme $data ");
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  sem: current_sem,
                  rec_data: data,
                  subject_name: subject,
                  credits: credit,
                ),
              ),
            );
            setState(() {
              isLoading = false;
            });
          }
        } catch (e) {
          print(e);
        }

        print(credit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: SecondaryColor,
        title: Text(
          "Profile",
          style: GoogleFonts.saira(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
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
                    children: [
                      Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: SecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 200,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.name}",
                                  style: GoogleFonts.saira(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Enrollment No.: ",
                            style: GoogleFonts.saira(
                                color: SecondaryColor,
                                fontSize: 16,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.enroll}",
                            style: GoogleFonts.saira(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Course:",
                            style: GoogleFonts.saira(
                              color: SecondaryColor,
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: Text(
                              "${courses[widget.enroll.toString().substring(6, 9)]}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.saira(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "College Name:",
                            style: GoogleFonts.saira(
                                color: SecondaryColor,
                                fontSize: 16,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              "${clg[clg_code[widget.enroll.toString().substring(3, 6)]]}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.saira(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.white,
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton<String>(
                            items: <String>[
                              'Sem 1',
                              'Sem 2',
                              'Sem 3',
                              'Sem 4',
                              'Sem 5',
                              'Sem 6',
                              'Overall'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: SecondaryColor),
                                ),
                              );
                            }).toList(),
                            icon: Icon(
                              Icons.arrow_downward_sharp,
                              color: SecondaryColor,
                            ),
                            focusColor: Colors.white,
                            underline: Container(
                              color: Colors.grey[200],
                              height: 2.0,
                            ),
                            hint: Text(
                              "Select Sem",
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                            onChanged: (newValue) {
                              //print(new_value);
                              setState(
                                () {
                                  current_sem = newValue;
                                },
                              );
                            },
                            value: current_sem,
                          ),
                        ],
                      ),

                      //See result Button
                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Fetching Result, Please Wait..."),
                            duration: Duration(
                              seconds: 2,
                            ),
                          ));
                          goToResult(context);
                        },
                        child: Text("See Your Result",
                            style: GoogleFonts.saira(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(5.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent[400],
                          ),
                        ),
                      ),
                      Visibility(
                        child: CircularProgressIndicator(),
                        visible: isLoading,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Visibility(
                        visible: isError,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          color: Colors.transparent,
                          child: Text(
                            "$msg",
                            style: GoogleFonts.saira(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
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
