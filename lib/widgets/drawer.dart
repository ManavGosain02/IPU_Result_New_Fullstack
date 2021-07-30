import 'package:flutter/material.dart';
import 'package:ipu_results/colors.dart';
import 'package:ipu_results/pages/about.dart';

class SideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: PrimaryColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/'),
                );
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "Ranklist",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "University Toppers",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.white,
              height: 0.1,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
