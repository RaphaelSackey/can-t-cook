import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cantcook/pages/scanned_page.dart';
import 'package:cantcook/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/customText.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late String prediction;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.veryHigh,
        enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<int> uploadImage(XFile img) async {
    final uri = Uri.parse("http://127.0.0.1:5000/predict");
    var request = http.MultipartRequest('POST', uri);
    var takenPicture = await http.MultipartFile.fromPath("image", img.path);
    request.files.add(takenPicture);

    var response = await request.send();
    if(response.statusCode == 200){
      print('Image uploaded!');
      // Read and parse the response JSON
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // Now you can access values from the JSON object
      prediction = jsonResponse['prediction'];
    } else{
      print('Image not uploaded');
    }
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size. width * 0.8,
      duration: const Duration(seconds: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)),
      content: CustomText(text:'Could not Connect to Backend!', size: 18, color: Colors.white, space: 1),
      backgroundColor:Colors.red,
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    final image = await _controller.takePicture();

                    if (!mounted) return;

                    var statusCode = await uploadImage(image);
                    if (statusCode == 200){
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ScannedPage(
                            prediction: prediction,
                            camera: widget.camera,
                            imagePath: image.path,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      )
    );
  }
}
