import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(Uint8List image, String folder) async {
  String? imageUrl;
  String fileName = '$folder/${DateTime.now().millisecondsSinceEpoch}';
  Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  UploadTask uploadTask = storageReference.putData(image, metadata);
  await uploadTask.whenComplete(
    () async {
      imageUrl = await storageReference.getDownloadURL();
    },
  );
  return imageUrl;
}

Future<void> deleteImage(String imagePath) async {
  try {
    Reference storageReference = FirebaseStorage.instance.refFromURL(imagePath);
    await storageReference.delete();
  } catch (error) {
    throw Exception('Error al borrar imagen: $error');
  }
}
