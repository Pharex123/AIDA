import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quotegen/bloc/voice_cubit.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({Key? key}) : super(key: key);

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  late VoiceCubit _voiceCubit;

  @override
  void initState() {
    super.initState();
    _voiceCubit = VoiceCubit();
  }

  @override
  void dispose() {
    _voiceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _voiceCubit,
      child: Scaffold(
        body: Center(
          child: BlocConsumer<VoiceCubit, VoiceState>(
            listener: (context, state) {
              if (state is VoiceError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is VoiceInitial) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/recording.json',
                      height: 200,
                      repeat: true,
                      animate: false,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _voiceCubit.startRecording();
                      },
                      child: const Text('Start Recording'),
                    )
                  ],
                );
              } else if (state is VoiceRecording) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/recording.json',
                      height: 200,
                      repeat: true,
                      animate: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _voiceCubit.stopRecording();
                      },
                      child: const Text('Stop Recording'),
                    ),
                  ],
                );
              } else if (state is VoiceRecorded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Recording Complete'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print(state.audioPath);
                        print("complete");
                        // Faire quelque chose avec les données audio enregistrées
                        // final audioData = state.audioData;
                        // ...
                      },
                      child: const Text('Play Recording'),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
