import 'package:equatable/equatable.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object?> get props => [];
}

class AudioInitial extends AudioState {}

class AudioPermissionGranted extends AudioState {}

class AudioPermissionDenied extends AudioState {}

class AudioRecording extends AudioState {
  final String path;

  const AudioRecording({required this.path});

  @override
  List<Object?> get props => [path];
}

class AudioRecorded extends AudioState {
  final String path;

  const AudioRecorded(this.path);

  @override
  List<Object?> get props => [path];
}

class AudioPlaying extends AudioState {
  final String path;

  const AudioPlaying({required this.path});

  @override
  List<Object?> get props => [path];
}
