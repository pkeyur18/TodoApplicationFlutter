import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Center(
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
                color: Color(0xFF39AA02),
                padding: EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF5DE61A),
                            Color(0xFF39AA02),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 50, right: 50, bottom: 15),
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
      ),
    );
  }
}
