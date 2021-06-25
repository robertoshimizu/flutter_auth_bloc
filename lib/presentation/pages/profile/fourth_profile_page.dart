import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../data/repository/firestore_cloud_repository.dart';
import '../../../data/repository/repositories.dart';
import '../../../domain/entities/entities.dart';
import '../../../locator.dart';

class FirstProfile4 extends StatelessWidget {
  final UserData user;
  final String imagePath;

  FirstProfile4({Key key, this.imagePath, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DataUserRepository api = locator<DataUserRepository>();
    return Scaffold(
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
                padding: const EdgeInsets.only(
                  top: 40.0,
                  bottom: 38.0,
                ),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/lockup-eu-indico.png'),
                    height: size.height * 0.16,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 7.0,
                )),
                padding: EdgeInsets.all(
                  35.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  child: Image.file(
                    File(imagePath),
                    scale: 3.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Flexible(
                child: Row(
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
                        var storageResult =
                            await cloudStorageService.uploadImage(
                                imageToUpload: selectedImage, title: title);

                        var imageUrl = storageResult.imageUrl;
                        user.photo = imageUrl;
                        user.registered = DateTime.now();
                        print('Confere User: ${user.toJson()}');

                        try {
                          await api.createUser(user.toJson());
                        } catch (error) {
                          print(error);
                        }

                        Phoenix.rebirth(context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
