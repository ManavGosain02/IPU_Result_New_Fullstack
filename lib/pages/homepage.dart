import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipu_results/colors.dart';
import 'package:ipu_results/pages/profilepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ipu_results/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String enrollment, name;
  final databaseRef = FirebaseDatabase.instance.reference();
  final firestoreInstance = FirebaseFirestore.instance;

  bool isLoading = false;
  // final Map<String, dynamic> clg_code = {
  //   'AIT': 248,
  //   'BITM': 205,
  //   'BMIET': 0,
  //   'COMM-IT': 120,
  //   'CPJCHS': [241, 215],
  //   'DTC': 0,
  //   'FITM': [901, 514],
  //   'IIT': 501,
  //   'IITM': [211, 137],
  //   'IITM2': [903, 244],
  //   'JEMTEC': 255,
  //   'JIMS': [140, 504],
  //   'JIMS-VK': [142, 214],
  //   'KCCILHE': 0,
  //   'KIHEAT': 967,
  //   'KIRAS': 144,
  //   'MSI': [149, 212],
  //   'RCIT': 158,
  //   'SCCTM': [243, 167],
  //   'SGIT': 247,
  //   'SGTBIMIT': 902,
  //   'TIHE': 172,
  //   'TIPS': [206, 240],
  //   'UCE': 0,
  //   'VIPS': [177, 298]
  // };
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
  final _form_key = GlobalKey<FormState>();

  gotohome(BuildContext context) async {
    if (_form_key.currentState.validate()) {
      //add_to_Firebase();
      print(enrollment);
      print(isLoading);

      var cc = (enrollment.toString().substring(3, 6));
      //var cy = int.parse(enrollment).toString().substring(6);
      setState(() {
        isLoading = true;
      });
      print(int.parse(enrollment));
      print(cc);
      await firestoreInstance
          .collection("Profile")
          .doc(cc)
          .get()
          .then((querySnapshot) {
        querySnapshot.data().forEach((key, value) {
          if (key == "${int.parse(enrollment)}") {
            print(value[0]["Name"]);
            setState(() {
              name = value[0]["Name"];
            });
          }
        });
      });
      // print(cy);
      // num tot = 0;
      // await firestoreInstance
      //     .collection("Result")
      //     .doc(cy)
      //     .collection(cc)
      //     .doc("Sem 4")
      //     .get()
      //     .then((querysnapshot) {
      //   querysnapshot.data().forEach((key, value) {
      //     if (key == "${int.parse(enrollment)}") {
      //       print(value[0].keys);
      //     }
      //   });
      // });
      setState(() {
        isLoading = false;
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            enroll: enrollment,
            name: name,
          ),
        ),
      );
    }
  }

  // void send_to_next() {
  //   print(enrollment);
  //   print(isLoading);

  //   var cc = enrollment.substring(3, 6);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   print(int.parse(enrollment));
  //   print(cc);
  //   firestoreInstance.collection("Profile").doc(cc).get().then((querySnapshot) {
  //     querySnapshot.data().forEach((key, value) {
  //       if (key == "${int.parse(enrollment)}") {
  //         print(value[0]["Name"]);
  //         setState(() {
  //           name = value[0]["Name"];
  //         });
  //       }
  //     });
  //   });
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  void add_to_Firebase() {
    databaseRef.once().then((DataSnapshot snapshot) async {
      for (var i in snapshot.value["120"]["2018"]) {
        print(i);
        if (i["Enrollment Number"] != "" &&
                i["Enrollment Number"] % 10000 == 2018 &&
                i["Enrollment Number"].toString().substring(2, 5) == "120" ||
            i["Enrollment Number"].toString().substring(3, 6) == "120") {
          await firestoreInstance
              .collection("Result")
              .doc("2018")
              .collection("120")
              .doc("Sem 4")
              .set({
            "${i["Enrollment Number"]}": FieldValue.arrayUnion([i])
          }, SetOptions(merge: true)).then((_) {
            print("Success");
          });
        }
      }
    });
  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
//   }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SecondaryColor,
        title: Text(
          "IPU Result",
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
                              image: AssetImage("assets/GGSIP-Logo.png"),
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
                        // child: Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Result I P",
                        //           style: GoogleFonts.firaSans(
                        //               color: Colors.white,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 20,
                        //               letterSpacing: 2.0),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 30.0,
                        //     ),
                        //     Image.asset(
                        //       "assets/GGSIP-Logo.png",
                        //       width: 150,
                        //     )
                        //   ],
                        // ),
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
                    key: _form_key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.0,
                          ),
                          TextFormField(
                            style: GoogleFonts.saira(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey[200],
                            ),
                            autofocus: false,
                            expands: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[200]),
                              ),
                              labelText: "Enrollment Number...",
                              labelStyle: TextStyle(
                                color: Colors.grey[200],
                                letterSpacing: 2.0,
                              ),
                              hintText: "Enter Enrollment number...",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enrollment Number cannot be empty";
                              } else if (clg_code[
                                      value.toString().substring(3, 6)] ==
                                  null) {
                                print(
                                    "incorrect: ${value.toString().substring(3, 6)}");
                                return "Enrollment number is incorrect";
                              } else if (value.length <= 9 ||
                                  value.length >= 13) {
                                try {
                                  print(int.parse(value));
                                } catch (error) {
                                  return "Enrollment number cannot be string or special character";
                                }
                              }
                              try {
                                print(int.parse(value));
                              } catch (error) {
                                return "emojis or spacial characters not allowed";
                              }

                              enrollment = value;
                              print("$enrollment \t $value");
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //send_to_next();
                              gotohome(context);
                            },
                            child: Text(
                              "Check Result",
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.all<double>(5.0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.greenAccent[400])),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     //send_to_next();
                          //     add_to_Firebase();
                          //   },
                          //   child: Text(
                          //     "add data",
                          //     style: GoogleFonts.lato(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          //   style: ButtonStyle(
                          //     elevation: MaterialStateProperty.all<double>(5.0),
                          //     backgroundColor: MaterialStateProperty.all<Color>(
                          //       Colors.greenAccent[400],
                          //     ),
                          //   ),
                          // ),
                          Visibility(
                            visible: isLoading,
                            child: CircularProgressIndicator(),
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
