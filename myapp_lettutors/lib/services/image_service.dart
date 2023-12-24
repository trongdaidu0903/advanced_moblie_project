import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class BothImageData {
  final Uint8List? image;
  final String? path;
  BothImageData(this.image, this.path);
}

class ImagePicService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';
  Future pickFile() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      return File(result!.files.single.path!);
    } catch (e) {
      log("Pick image error:${e.toString()}");
    }
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  static Future<BothImageData?> selectedImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      final image = await file.readAsBytes();
      final path = file.path;
      return BothImageData(image, path);
    }
    return null;
  }

  void pickListImage(Function(List<Uint8List>) callback) async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? files = await picker.pickMultiImage();
    List<Uint8List> images = [];
    for (var file in files) {
      Uint8List image = await file.readAsBytes();
      images.add(image);
    }
    callback(images);
  }

  static Future<bool> uploadAvatar(
      {required String path, required String token}) async {
    try {
      final response = await Dio().post(
        "$baseUrl/user/uploadAvatar",
        data: FormData()
          ..files.add(
            MapEntry(
              "avatar",
              MultipartFile.fromFileSync(
                path,
                filename: path.split("/").last,
              ),
            ),
          ),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "content-type": "application/json;encoding=utf-8",
            "Accept": "*/*",
          },
        ),
      );
      print(response.data);

      return response.statusCode == 200;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
