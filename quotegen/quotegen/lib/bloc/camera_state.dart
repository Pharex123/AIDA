// import 'dart:io';
// import 'package:equatable/equatable.dart';

// abstract class CameraState extends Equatable {
//   const CameraState();

//   @override
//   List<Object?> get props => [];
// }

// class CameraInitial extends CameraState {}

// class CameraLoading extends CameraState {}

// class CameraLoaded extends CameraState {
//   final File image;

//   const CameraLoaded(this.image);

//   @override
//   List<Object?> get props => [image];
// }

// class CameraError extends CameraState {
//   final String message;

//   const CameraError(this.message);

//   @override
//   List<Object?> get props => [message];
// }


import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraLoaded extends CameraState {
  final File image;

  const CameraLoaded(this.image);

  @override
  List<Object?> get props => [image];
}

class CameraError extends CameraState {
  final String message;

  const CameraError(this.message);

  @override
  List<Object?> get props => [message];
}
