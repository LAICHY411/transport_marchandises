import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

Future<Uint8List?> SelectionImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked == null) return null;
  final Uint8List imageBytes = await picked.readAsBytes();
  return imageBytes;
}
