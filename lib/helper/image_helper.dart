import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imageCropper = imageCropper ?? ImageCropper(),
        _imagePicker = imagePicker ?? ImagePicker();
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);

    if (file != null) return file;
    return null;
  }

  Future<CroppedFile?> crop(
          {required XFile file,
          CropStyle cropStyle = CropStyle.circle}) async =>
      await _imageCropper.cropImage(
          sourcePath: file.path, cropStyle: cropStyle, compressQuality: 100);
}
