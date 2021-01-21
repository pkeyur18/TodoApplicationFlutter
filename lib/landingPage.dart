import 'package:Todo/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db/userdetailsDatabaseHelper.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var userDetailsProvider;

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = Provider.of<UserdetailsDBHelper>(context);
    return FutureBuilder(
      future: userDetailsProvider.getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Oops..! Some error has occured."),
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data.userName != null) {
            return HomeTasksPage(snapshot.data);
          } else {
            return getLandingPage();
          }
        } else {
          return landingPageSkeleton();
        }
      },
    );
  }

  Widget getLandingPage() {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/notelist.png',
              width: MediaQuery.of(context).size.width * 0.65,
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                "Reminders made simple",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF554E8F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: 50,
                right: 50,
              ),
              child: Text(
                "Your busy life deserves this. Now manage your daily activities with simple ToDo app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF82A0B7),
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 80,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/homepage');
              },
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF7EB6FF),
                      Color(0xFF5F87E7),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 15, left: 80, right: 80, bottom: 15),
                  child: const Text(
                    "Let's Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landingPageSkeleton() {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            'assets/images/landingpageloading.png',
          ),
          width: MediaQuery.of(context).size.width * 0.75,
        ),
      ),
    );
  }
}
