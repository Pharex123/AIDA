// import 'package:bloc/bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'camera_state.dart';

// class CameraCubit extends Cubit<CameraState> {
//   final ImagePicker _picker = ImagePicker();

//   CameraCubit() : super(CameraInitial());

//   Future<void> pickImageFromGallery() async {
//     try {
//       emit(CameraLoading());
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         emit(CameraLoaded(File(pickedFile.path)));
//       } else {
//         emit(const CameraError("No image selected"));
//       }
//     } catch (e) {
//       emit(CameraError(e.toString()));
//     }
//   }

//   Future<void> pickImageFromCamera() async {
//     try {
//       emit(CameraLoading());
//       final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedFile != null) {
//         emit(CameraLoaded(File(pickedFile.path)));
//       } else {
//         emit(const CameraError("No image selected"));
//       }
//     } catch (e) {
//       emit(CameraError(e.toString()));
//     }
//   }
// }


import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  final ImagePicker _picker = ImagePicker();

  CameraCubit() : super(CameraInitial());

  Future<void> pickImageFromGallery() async {
    try {
      emit(CameraLoading());
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(CameraLoaded(File(pickedFile.path)));
      } else {
        emit(const CameraError("No image selected"));
      }
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      emit(CameraLoading());
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        emit(CameraLoaded(File(pickedFile.path)));
      } else {
        emit(const CameraError("No image selected"));
      }
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }
}
