import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/repository/firestore_cloud_repository.dart';
import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../locator.dart';
import '../pages.dart';

class FirstProfile4 extends StatelessWidget {
  final UserData user;
  final String imagePath;

  FirstProfile4({Key key, this.imagePath, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DataUserRepository api = locator<DataUserRepository>();
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        padding: EdgeInsets.all(5.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Verifique se seu rosto está visível e a foto não está tremida',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // CircleAvatar(
              //   radius: (100),
              //   backgroundColor: Colors.transparent,
              //   backgroundImage: FileImage(imagePath),
              // ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 120,
                child: ClipOval(
                  child: Image.file(
                    File(imagePath),
                    scale: 2.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 50, // Will take 50% of screen space
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(
                        color: Color(0xFF00B878),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => FirstProfile3()));
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Tirar outra',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF00B878),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.35,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)),
                    onPressed: () async {
                      var title = (user.uid).substring(0, 7);
                      var selectedImage = File(imagePath);
                      var cloudStorageService = CloudStorageService();
                      var storageResult = await cloudStorageService.uploadImage(
                          imageToUpload: selectedImage, title: title);

                      var imageUrl = storageResult.imageUrl;

                      try {
                        // create user with UserData
                        //
                        //
                        // await api.updateUserfield(
                        //   id: user.uid,
                        //   key: 'photo',
                        //   value: imageUrl,
                        // );
                      } catch (error) {}

                      // Remove all stack pages

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      "Gostei",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xFF00B878),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
