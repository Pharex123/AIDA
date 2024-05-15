import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
part 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  VoiceCubit() : super(VoiceInitial());

  
final record = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioPath;

  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      emit(VoiceError(error: 'Microphone permission denied'));
      return;
    }

    emit(VoiceRecording());
    try {
      // Obtenir le répertoire des documents externes
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/audio_recording.m4a';
    print(filePath);

    // Créer un fichier pour l'enregistrement
    final file = File(filePath);
      // await _audioRecorder.start(
      //   encoder: AudioEncoder.aacLc,
      //   bitRate: 128000,
      // );
       // Start recording to file
      await record.start(const RecordConfig(), path: filePath);
      final stream = await record.startStream(const RecordConfig(encoder: AudioEncoder.aacLc));
    } catch (e) {
      emit(VoiceError(error: 'Error during recording start'));
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await record.stop();
      await record.cancel();
      // Introduce a short delay to allow the writer to finish
    // await Future.delayed(const Duration(milliseconds: 100));
      emit(VoiceRecorded(audioPath: path!));
    } catch (e) {
      emit(VoiceError(error: 'Error during recording stop'));
    }
  }

  Future<void> playRecording() async {
    try {
      emit(VoicePlaying());
      Source urlSource = UrlSource(_audioPath!);
      await _audioPlayer.play(urlSource);
      _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        if (state == PlayerState.completed) {
          emit(VoiceInitial());
        }
      });
    } catch (e) {
      emit(VoiceError(error: 'Error during audio playback'));
    }
  }

  Future<void> pauseRecording() async {
    try {
      await _audioPlayer.pause();
      emit(VoicePaused());
    } catch (e) {
      emit(VoiceError(error: 'Error during audio pause'));
    }
  }

  @override
  Future<void> close() {
    record.dispose();
    _audioPlayer.dispose();
    return super.close();
  }
}