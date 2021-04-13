// A screen that takes in a list of cameras and the Directory to store images.
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../pages.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key key,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    print('Initiating available cameras');
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      print(cameras);
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 1;
        });
        _controller = CameraController(
          cameras[selectedCameraIdx],
          ResolutionPreset.medium,
        );
        print('_controller antes: $_controller');
        _initializeControllerFuture = _controller.initialize();
        print('_controller inicializado?: $_controller');
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          print(snapshot.connectionState.toString());
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            print('Connection State is done, indo para Camera Preview');
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            );
          } else {
            print('loading');
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            // await _controller.takePicture(path);
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FirstProfile4(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
