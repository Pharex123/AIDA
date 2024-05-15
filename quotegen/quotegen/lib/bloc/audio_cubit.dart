import 'package:bloc/bloc.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'audio_state.dart';
import 'dart:io';

class AudioCubit extends Cubit<AudioState> {
  final  _record = AudioRecorder(); 

  AudioCubit() : super(AudioInitial());

  Future<void> checkPermissions() async {
    if (await Permission.microphone.request().isGranted) {
      emit(AudioPermissionGranted());
    } else {
      emit(AudioPermissionDenied());
    }
  }

  Future<void> startRecording() async {
    if (await _record.hasPermission()) {
      Directory tempDir = await getTemporaryDirectory();
      String path = '${tempDir.path}/audio_recording.m4a';
      emit(AudioRecording(path: path));

      await _record.start(
        const RecordConfig(),
        path: path,
        // encoder: AudioEncoder.aacLc,
        // bitRate: 128000,
        // samplingRate: 44100,
      );
    }
  }

  Future<void> stopRecording() async {
    await _record.stop();
    if (state is AudioRecording) {
      emit(AudioRecorded((state as AudioRecording).path));
    }
  }

  Future<void> startPlaying(String path) async {
    emit(AudioPlaying(path: path));
  }

  Future<void> stopPlaying() async {
    if (state is AudioPlaying) {
      emit(AudioRecorded((state as AudioPlaying).path));
    }
  }
}
