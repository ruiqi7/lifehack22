import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: 'gs://lifehack22-b99fe.appspot.com'
  );

  Future<String> uploadFile(XFile image, String uid, bool saved) async {
    String filePath;
    if (saved) {
      filePath = 'savedThumbnail/$uid';
    } else {
      filePath = 'temporaryThumbnail/$uid';
    }
    Reference storageReference = storage.ref().child(filePath);
    TaskSnapshot uploadedTask = await storageReference.putFile(File(image.path));
    String downloadURL = await uploadedTask.ref.getDownloadURL();
    return downloadURL;
  }
}