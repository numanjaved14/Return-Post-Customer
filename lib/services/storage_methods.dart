import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<String>  uploadImageToStorage(String childName, Uint8List file)async{
  Reference ref = _firebaseStorage.ref(childName).child(_firebaseAuth.currentUser!.uid);

  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot taskSnapshot = await uploadTask;

  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}


}