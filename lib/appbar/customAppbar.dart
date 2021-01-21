import 'dart:io';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/model/userDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppBar extends StatefulWidget {
  final String _subHeading;
  final UserDetails userDetails;
  final bool loading;

  CustomAppBar(
    this.userDetails,
    this._subHeading,
    this.loading,
  );

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  File newImage;
  ImagePicker picker = new ImagePicker();
  Directory directory;
  String imagepath;
  Future<File> tempImage;
  var textController;
  var dbhelper;

  @override
  Widget build(BuildContext context) {
    dbhelper = Provider.of<DBHelper>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 18,
        left: 16,
        right: 18,
      ),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => editUserDetails(),
              child: Row(
                children: [
                  Container(
                    child: widget.loading
                        ? Shimmer.fromColors(
                            child: CircleAvatar(
                              backgroundColor: Color(0xFFABCDEF),
                              radius: 22.0,
                            ),
                            baseColor: Color(0xFFABCDEF),
                            highlightColor: Colors.white,
                          )
                        : CircleAvatar(
                            backgroundColor: Color(0xFFABCDEF),
                            child: Text(profilePictureName()),
                            radius: 22.0,
                          ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.loading
                          ? Shimmer.fromColors(
                              child: Text(
                                "Hi...",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.white,
                            )
                          : Text(
                              "Hi ${userName()}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFF1F1F1),
                              ),
                            ),
                      SizedBox(
                        height: 2,
                      ),
                      widget.loading
                          ? Shimmer.fromColors(
                              child: Text(
                                widget._subHeading,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.white,
                            )
                          : Text(
                              widget._subHeading,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF1F1F1),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editUserDetails() async {
    // profilePictureName();
    textController = TextEditingController(
      text: widget.userDetails.userName,
    );
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          title: Text("Edit your name"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextFormField(
              controller: textController,
              style: TextStyle(
                fontSize: 15,
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value.length < 1) {
                  return "Please enter atleast 1 character";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              cursorColor: Theme.of(context).cursorColor,
              maxLength: 24,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                hintText: 'Kristen...',
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF554E8F),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF554E8F),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "Discard",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                if (textController.text.length >= 1) {
                  UserDetails user = new UserDetails(
                    id: widget.userDetails.id,
                    userName: textController.text,
                    profilePicture: widget.userDetails.profilePicture,
                  );
                  setState(() {
                    widget.userDetails.userName = textController.text;
                  });
                  dbhelper.updateUsernameDetails(user);
                  Navigator.of(context).pop(true);
                } else {}
              },
              child: const Text(
                "Apply",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String userName() {
    if (widget.userDetails != null) {
      if (widget.userDetails.userName != null) {
        String tempName = widget.userDetails.userName.trim();
        tempName = tempName.replaceAll(new RegExp(r"\s+\b|\b\s"), " ");
        return tempName;
      }
    }
    return '';
  }

  String profilePictureName() {
    if (widget.userDetails != null) {
      if (widget.userDetails.userName != null) {
        String tempName = widget.userDetails.userName.trim();
        tempName = tempName.replaceAll(new RegExp(r"\s+\b|\b\s"), " ");
        List<String> name = tempName.split(" ");
        if (name.length > 2) {
          List<String> tempList = name;
          name = new List();
          for (var i = 0; i < 2; i++) {
            name.add(tempList[i]);
          }
        }
        String profileName = '';
        name.forEach((element) {
          profileName = profileName + element.substring(0, 1);
        });
        return profileName;
      }
    }
    return 'HI';
  }
}
