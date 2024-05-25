// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_course/models/file_upload_response.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? pathFiles;
  String message = '';
  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Image'),
      ),
      body: Column(
        children: [
          message == ''
              ? SizedBox(
                  height: sizeWidth,
                  width: sizeWidth / 2,
                  child: Image.file(File(pathFiles ?? '')),
                )
              : Text(message),
          ElevatedButton(
              onPressed: () {
                captureImage();
              },
              child: const Text('Capture Image')),
          ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: const Text('Upload Image'))
        ],
      ),
    );
  }

  Future captureImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pathFiles = image!.path;
    });
  }

  Future uploadImage() async {
    try {
      var requestModel = FormData.fromMap(
          {'photo': MultipartFile.fromFileSync(pathFiles ?? '')});
      var response = await Dio().post(
        'http://192.168.1.4:8080/api/upload',
        data: requestModel,
      );
      FileUploadResponse result = FileUploadResponse.fromJson(response.data);

      setState(() {
        message = result.message ?? '';
      });
    } catch (e) {
      setState(() {
        message = e.toString();
      });
      print('Error Upload : $message');
    }
  }
}
