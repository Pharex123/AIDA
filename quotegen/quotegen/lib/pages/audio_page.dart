// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'dart:io';

// class AudioPage extends StatefulWidget {
//   @override
//   _AudioPageState createState() => _AudioPageState();
// }

// class _AudioPageState extends State<AudioPage> {
//   final  _record = AudioRecorder(); // Correct instantiation
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isRecording = false;
//   bool _isPlaying = false;
//   String? _audioPath;

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }

//   Future<void> _checkPermissions() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       // throw RecordingPermissionException('Microphone permission not granted');
//     }
//   }

//   Future<void> _startRecording() async {
    
//       Directory tempDir = await getTemporaryDirectory();
//       String path = '${tempDir.path}/audio_recording.m4a';
//       setState(() {
//         _audioPath = path;
//       });
//       await _record.start(
//         const RecordConfig(),
//         path: path,
//         // encoder: AudioEncoder.aacLc,
//         // bitRate: 128000,
//         // samplingRate: 44100,
//       );
//       setState(() {
//         _isRecording = true;
//       });
    
//   }

//   Future<void> _stopRecording() async {
//     await _record.stop();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   Future<void> _startPlaying() async {
//     if (_audioPath != null) {
//       await _audioPlayer.play(DeviceFileSource(_audioPath!));
//       setState(() {
//         _isPlaying = true;
//       });
//       _audioPlayer.onPlayerComplete.listen((event) {
//         setState(() {
//           _isPlaying = false;
//         });
//       });
//     }
//   }

//   Future<void> _stopPlaying() async {
//     await _audioPlayer.stop();
//     setState(() {
//       _isPlaying = false;
//     });
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _record.dispose(); // Ensure to dispose of the recorder
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _isRecording ? _stopRecording : _startRecording,
//               child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: (_audioPath != null && !_isPlaying) ? _startPlaying : null,
//               child: Text('Play Recording'),
//             ),
//             if (_audioPath != null)
//               Text('Recording saved at: $_audioPath'),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:lottie/lottie.dart';
// import 'package:quotegen/bloc/audio_cubit.dart';
// import 'package:quotegen/bloc/audio_state.dart';

// class AudioPage extends StatelessWidget {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AudioCubit()..checkPermissions(),
//       child: Scaffold(
//         body: Center(
//           child: BlocConsumer<AudioCubit, AudioState>(
//             listener: (context, state) {
//               if (state is AudioPlaying) {
//                 _audioPlayer.play(DeviceFileSource(state.path));
//                 _audioPlayer.onPlayerComplete.listen((event) {
//                   context.read<AudioCubit>().stopPlaying();
//                 });
//               } else if (state is AudioRecorded) {
//                 _audioPlayer.stop();
//               }
//             },
//             builder: (context, state) {
//               Widget animationWidget;

//               if (state is AudioInitial || state is AudioPermissionGranted) {
//                 animationWidget = Lottie.asset('assets/animations/recording.json');
//               } else if (state is AudioPermissionDenied) {
//                 animationWidget = Text('Microphone permission denied');
//               } else if (state is AudioRecording) {
//                 animationWidget = Lottie.asset('assets/animations/recorded.json');
//               } else if (state is AudioRecorded) {
//                 animationWidget = Lottie.asset('assets/animations/recording.json');
//               } else if (state is AudioPlaying) {
//                 animationWidget = Lottie.asset('assets/animations/playing.json');
//               } else {
//                 animationWidget = Container();
//               }

//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   animationWidget,
//                   SizedBox(height: 20),
//                   if (state is AudioInitial || state is AudioPermissionGranted)
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<AudioCubit>().startRecording();
//                       },
//                       child: Text('Start Recording'),
//                     ),
//                   if (state is AudioRecording)
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<AudioCubit>().stopRecording();
//                       },
//                       child: Text('Stop Recording'),
//                     ),
//                   if (state is AudioRecorded)
//                     Column(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<AudioCubit>().startRecording();
//                           },
//                           child: Text('Start Recording'),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<AudioCubit>().startPlaying(state.path);
//                           },
//                           child: Text('Play Recording'),
//                         ),
//                       ],
//                     ),
//                   if (state is AudioPlaying)
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<AudioCubit>().stopPlaying();
//                       },
//                       child: Text('Stop Playing'),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:quotegen/bloc/audio_cubit.dart';
import 'package:quotegen/bloc/audio_state.dart';

class AudioPage extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioCubit()..checkPermissions(),
      child: Scaffold(
        body: Center(
          child: BlocConsumer<AudioCubit, AudioState>(
            listener: (context, state) {
              if (state is AudioPlaying) {
                _audioPlayer.play(DeviceFileSource(state.path));
                _audioPlayer.onPlayerComplete.listen((event) {
                  context.read<AudioCubit>().stopPlaying();
                });
              } else if (state is AudioRecorded ) {
                _audioPlayer.stop();
              }
            },
            builder: (context, state) {
              Widget animationWidget;

              if (state is AudioInitial || state is AudioPermissionGranted) {
                animationWidget = Lottie.asset('assets/animations/recording.json');
              } else if (state is AudioPermissionDenied) {
                animationWidget = Text('Microphone permission denied');
              } else if (state is AudioRecording) {
                animationWidget = Lottie.asset('assets/animations/playing.json');
              } else if (state is AudioRecorded) {
                animationWidget = Lottie.asset('assets/animations/recording.json');
              } else if (state is AudioPlaying) {
                animationWidget = Lottie.asset('assets/animations/playing.json');
              // } else if (state is AudioSentSuccess) {
              //   animationWidget = Lottie.asset('assets/animations/success.json');
              // } else if (state is AudioSentFailure) {
              //   animationWidget = Lottie.asset('assets/animations/failure.json');
               } else {
                animationWidget = Container();
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  animationWidget,
                  SizedBox(height: 20),
                  if (state is AudioInitial || state is AudioPermissionGranted)
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioCubit>().startRecording();
                      },
                      child: Text('Start Recording'),
                    ),
                  if (state is AudioRecording)
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioCubit>().stopRecording();
                      },
                      child: Text('Stop Recording'),
                    ),
                  if (state is AudioRecorded)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<AudioCubit>().startRecording();
                          },
                          child: Text('Start Recording'),
                        ),
                        SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     context.read<AudioCubit>().startPlaying(state.path);
                        //   },
                        //   child: Text('Play Recording'),
                        // ),
                        SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _showLanguageSelectionDialog(context);
                        //   },
                        //   child: Text('Send Recording'),
                        // ),
                      ],
                    ),
                  if (state is AudioPlaying)
                    ElevatedButton(
                      onPressed: () {
                        context.read<AudioCubit>().stopPlaying();
                      },
                      child: Text('Stop Playing'),
                    ),
                ],
              );
            },
          ),
        ),
      ),
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
              ListTile(
                title: Text("Fon"),
                onTap: () {
                  // context.read<AudioCubit>().sendAudio('Fon');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Yoruba"),
                onTap: () {
                  // context.read<AudioCubit>().sendAudio('Yoruba');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  
}
