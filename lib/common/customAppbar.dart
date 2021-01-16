import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  final String _username;
  final String _subHeading;
  final String _imageUrl;

  CustomAppBar(this._username, this._subHeading, this._imageUrl);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  var profilePictureProvider;
  @override
  Widget build(BuildContext context) {
    profilePictureProvider = Provider.of<ProfileImageProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 18,
        left: 18,
        right: 18,
      ),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Provider.of<ProfileImageProvider>(
                    context,
                    listen: false,
                  ).getImage(),
                  child: FutureBuilder(
                    future: profilePictureProvider.getFile(),
                    builder: (context, snapshot) {
                      return Container(
                        child: profilePictureProvider.newImage == null
                            ? CircleAvatar(
                                backgroundColor: Color(0xFFD10263),
                                child: Text("KP"),
                                radius: 24.0,
                              )
                            : CircleAvatar(
                                radius: 24.0,
                                backgroundImage: Image.file(
                                  snapshot.data,
                                  fit: BoxFit.fill,
                                ).image,
                              ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget._username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF1F1F1),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
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
          ],
        ),
      ),
    );
  }
}

class CustomAppBarForPending extends StatelessWidget {
  final String _username;
  final String _imageUrl;

  CustomAppBarForPending(this._username, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 18,
        left: 18,
        right: 18,
      ),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF1F1F1),
                  ),
                ),
              ],
            ),
            Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(_imageUrl),
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImageProvider with ChangeNotifier {
  File newImage;
  ImagePicker picker = new ImagePicker();
  Directory directory;
  String imagepath;

  Future initializePath() async {
    directory = await getApplicationDocumentsDirectory();
    imagepath = directory.path;
    print("initialize path");
  }

  getFile() async {
    await initializePath();
    newImage = File('$imagepath/profileimage.png');
    return newImage;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      newImage =
          await File(pickedFile.path).copy('$imagepath/profileimage.png');
    }
    notifyListeners();
  }
}
