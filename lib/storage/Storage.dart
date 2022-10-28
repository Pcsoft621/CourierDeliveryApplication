//import 'package:get'
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage=
  firebase_storage.FirebaseStorage.instance;
  Future<String> downloadUrl(String imageName)async{
    String downloadUrl=await storage.ref('images/userprofiledetails/$imageName').getDownloadURL();
    return downloadUrl;
  }
}