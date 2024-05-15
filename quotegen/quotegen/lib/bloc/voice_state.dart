part of 'voice_cubit.dart';

abstract class VoiceState extends Equatable {
  const VoiceState();

  @override
  List<Object> get props => [];
}

class VoiceInitial extends VoiceState {}

class VoiceRecording extends VoiceState {}

class VoiceRecorded extends VoiceState {
  final String audioPath;

  const VoiceRecorded({required this.audioPath});

  @override
  List<Object> get props => [audioPath];
}

class VoicePlaying extends VoiceState {}

class VoicePaused extends VoiceState {}

class VoiceError extends VoiceState {
  final String error;

  const VoiceError({required this.error});

  @override
  List<Object> get props => [error];
}