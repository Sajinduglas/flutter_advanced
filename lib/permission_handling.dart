

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
void main(){
  runApp(MaterialApp(
    home:Permisionss() ,
  ));
}

class Permisionss extends StatelessWidget {
  const Permisionss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            askCameraPermission(context);
          }, child: Text("camera")),

          ElevatedButton(onPressed: () {
            askMultiplePermission();
          }, child: Text("Multiple permission")),

          ElevatedButton(onPressed: () {
            openSEttings();
          }, child: Text("settings")),
        ],
      ),
    );
  }

  void askCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;
    if (await Permission.camera
        .request()
        .isGranted) {
      var picker = ImagePicker();
      picker.pickImage(source: ImageSource.camera);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //     SnackBar(content: Text("permission denied")));
    }
  }

  void openSEttings() async {
    openAppSettings();
  }

  void askMultiplePermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.contacts,
      Permission.photos,
      Permission.microphone,
      Permission.phone
    ].request();
    print(
        'Location ${status[Permission.location]} \ncamera ${status[Permission
            .phone]}');
  }
}
// ///amos
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: PermissionEx(),
//   ));
// }
//
// class PermissionEx extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Permission Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   askCameraPermission(context);
//                 },
//                 child: Text('CAmera')),
//             ElevatedButton(
//                 onPressed: () {
//                   askMultiplePermissions();
//                 },
//                 child: Text('Multiple Permissions')),
//             ElevatedButton(
//                 onPressed: () {
//                   openSettings();
//                 },
//                 child: Text('Settings')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void askCameraPermission(BuildContext context) async {
//     var status = await Permission.camera.status;
//     if (await Permission.camera.request().isGranted) {
//       var picker = ImagePicker();
//       picker.pickImage(source: ImageSource.camera);
//     } else if (status.isDenied) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Permission Denied")));
//     }
//   }
//
//   void askMultiplePermissions() async {
//     Map<Permission, PermissionStatus> status = await [
//       Permission.location,
//       Permission.contacts,
//       Permission.photos,
//       Permission.microphone,
//       Permission.phone
//     ].request();
//     print(
//         'Location ${status[Permission.location]} \ncamera ${status[Permission.phone]}');
//   }
//
//   void openSettings() async {
//     openAppSettings();
//   }
// }