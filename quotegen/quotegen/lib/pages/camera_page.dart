// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CameraPage extends StatefulWidget {
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_image != null)
//               Image.file(
//                 _image!,
//                 height: 300,
//               )
//             else
//               Text('No image selected.'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Pick Image from Gallery'),
//             ),
//             ElevatedButton(
//               onPressed: _pickImageFromCamera,
//               child: Text('Take a Photo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotegen/bloc/camera_cubit.dart';
import 'package:quotegen/bloc/camera_state.dart';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String _statusMessage = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: BlocBuilder<CameraCubit, CameraState>(
                builder: (context, state) {
                  if (state is CameraInitial) {
                    return Text('No image selected.');
                  } else if (state is CameraLoading) {
                    return CircularProgressIndicator();
                  } else if (state is CameraLoaded) {
                    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.file(
                      state.image,
                      height: 300,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _showLanguageSelectionDialog(context),
                      child: Text('Listen'),
                    ),
                  ],
                );
                  } else if (state is CameraError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showPickerDialog(context),
              child: Icon(Icons.add_a_photo),
            ),
          );
        }
      ),
    );
  }

  void _showPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Select option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Pick from Gallery"),
                onTap: () {
                  BlocProvider.of<CameraCubit>(context).pickImageFromGallery();
                  Navigator.of(dialogContext).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Take a Photo"),
                onTap: () {
                  BlocProvider.of<CameraCubit>(context).pickImageFromCamera();
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ListTile(
              //   title: Text("Fon"),
              //   onTap: () {
              //     // Call the function to listen in Fon
              //     _listenInLanguage(context, 'Fon');
              //     Navigator.of(context).pop();

              //   },
              // ),
              ListTile(
                title: Text("Yoruba"),
                onTap: () {
                  _listenInLanguage(context, 'yoruba.mp3');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _listenInLanguage(BuildContext context, String audioFile) async {
    await _audioPlayer.play(DeviceFileSource(audioFile));
    setState(() {
      _statusMessage = 'Terminer';
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        _statusMessage = '';
      });
    });
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quotegen/bloc/camera_cubit.dart';
// import 'package:quotegen/bloc/camera_state.dart';

// class CameraPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CameraCubit(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Picker Example'),
//         ),
//         body: Center(
//           child: BlocBuilder<CameraCubit, CameraState>(
//             builder: (context, state) {
//               if (state is CameraInitial) {
//                 return Text('No image selected.');
//               } else if (state is CameraLoading) {
//                 return CircularProgressIndicator();
//               } else if (state is CameraLoaded) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image.file(
//                       state.image,
//                       height: 300,
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () => _showLanguageSelectionDialog(context),
//                       child: Text('Listen'),
//                     ),
//                   ],
//                 );
//               } else if (state is CameraError) {
//                 return Text(state.message);
//               }
//               return Container();
//             },
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _showPickerDialog(context),
//           child: Icon(Icons.add_a_photo),
//         ),
//       ),
//     );
//   }

//   void _showPickerDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text("Select option"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text("Pick from Gallery"),
//                 onTap: () {
//                   BlocProvider.of<CameraCubit>(context).pickImageFromGallery();
//                   Navigator.of(dialogContext).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text("Take a Photo"),
//                 onTap: () {
//                   BlocProvider.of<CameraCubit>(context).pickImageFromCamera();
//                   Navigator.of(dialogContext).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showLanguageSelectionDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select Language"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: Text("Fon"),
//                 onTap: () {
//                   // Call the function to listen in Fon
//                   _listenInLanguage(context, 'Fon');
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("French"),
//                 onTap: () {
//                   // Call the function to listen in French
//                   _listenInLanguage(context, 'French');
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _listenInLanguage(BuildContext context, String language) {
//     // Implement the function to listen in the selected language
//     print("Listening in $language");
//     // You can replace this with the actual implementation
//   }
// }
