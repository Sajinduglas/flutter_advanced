import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDYrDyx_hirkEI9UR0xncX7JzzFasuoP_Q",
          appId: "1:119405132167:android:6c00ea5bb3b94db0e4fb22",
          messagingSenderId: " ",
          projectId: "fir-new-flutter-project",
          storageBucket: "fir-new-flutter-project.appspot.com"));
  runApp(MaterialApp(
    home: FirebaseImageStorage(),
  ));
}

class FirebaseImageStorage extends StatefulWidget {
  // const FirebaseImageStorage({super.key});

  @override
  State<FirebaseImageStorage> createState() => _FirebaseImageStorageState();
}

class _FirebaseImageStorageState extends State<FirebaseImageStorage> {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Store'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () => upload("camera"),
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text('Camera')),
                ElevatedButton.icon(
                    onPressed: () => upload("gallery"),
                    icon: Icon(Icons.photo),
                    label: Text('Gallery'))
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: loadMedia(),
                  //images returned from method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(

                        itemBuilder: (context, index) {
                          final image = snapshot.data![index]; ///ethu doubt
                          return Card(
                            child: ListTile(
                              leading: Image.network(image['imageUrl']),///if snapshot.data![index]; if ethu vilichilla enkil Image.network(image[index]['imageUrl']), engannai ayannai
                              title: Text(image["uploadedBy"]),
                              subtitle: Text(image['time']),  
                              trailing: IconButton(
                                  onPressed: () => deleteMedia(image['path']),
                                  icon: Icon(Icons.delete)),
                            ),
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0,
                      );
                    }
                    return CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }

  Future<void> upload(String imageFrom) async {
    final picker = ImagePicker();///image pick cheyann picker inte instance call cheythu
    XFile? pickedImage;///edukunnai image store cheyunathinte path edukaan ayittu



   ///1 st try catch image edukumbolveran chance ulla exception handleing
    try {
      pickedImage = await picker.pickImage(
          source:
              imageFrom == "camera" ? ImageSource.camera : ImageSource.gallery);
      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      ///2 try catch  firebase il image upload cheyumbol exception handleing veram net pokam, firebase connection pokam

      try {
        await storage.ref(fileName).putFile(///firebase instance .putfile current reference edukan aaa .ref (means file int name)
            imageFile,
            SettableMetadata(customMetadata: {
              "uploadedBy": "phoneName",
              'time': '${DateTime.now()}'
            }));
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (error) {
      print(error);
    }
  }

  ///load images from firebase
  Future<List<Map<String, dynamic>>> loadMedia() async {
    List<Map<String, dynamic>> images = [];
    final ListResult result = await storage.ref().list(); //11.54refer     firebase il ninnu verunnai image chumma list ayittu edukkan pattulla ,  list result(class) ennu name ulla firebase storage inte class il ninnai edukkan pattu
    final List<Reference> allFiles = result.items;   ///result il store cheythai each value edukkan means with eg sqfltiteilai each id edukkunnai way pollai
    await Future.forEach(allFiles, (singleFile) async {
      final String fileUrl = await singleFile.getDownloadURL();
      final FullMetadata metadata = await singleFile
          .getMetadata(); //angot settable metadata vech ayiurnn, but engot full metadata vech aa edukunna
      images.add({
        'imageUrl': fileUrl,
        'path': singleFile.fullPath,
        'uploadedBy': metadata.customMetadata?['uploadedBy'] ?? "no Data",
        'time': metadata.customMetadata?['time'] ?? "NO Time Found"
      });
    });
    return images;
  }

  Future<void> deleteMedia(String imagePath) async {
    await storage.ref(imagePath).delete();
    setState(() {});
  }
}
