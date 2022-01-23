import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
    // var img = Image(
    //     image: ResizeImage(
    //   MemoryImage(
    //     await _file.readAsBytes(),
    //   ),
    //   width: 128,
    //   height: 128,
    // ));
    // img.
  }
}