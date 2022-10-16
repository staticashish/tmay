import 'dart:io';

import 'package:ffmpeg_kit_flutter_full/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/screens/video_player_screen.dart';
import 'package:tmay/utils/colors_utils.dart';
import 'package:tmay/utils/video_utils.dart';

class AddVideoScreen extends StatefulWidget {
  final QuestionModel questionModel;
  const AddVideoScreen({Key? key, required this.questionModel})
      : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  XFile? _inputVideo;

  _videoFromCamera() async {
    _inputVideo = await ImagePicker().pickVideo(
      source: ImageSource.camera,
    );
    var outputVideoName = widget.questionModel.key.toString();
    var tempDir = await getTemporaryDirectory();
    XFile? outputFile = XFile("${tempDir.path}/$outputVideoName.mp4");
    await addTextOnVideo(
            _inputVideo!.path, outputFile.path, widget.questionModel.question!)
        .then((sessionFuture) => {
              sessionFuture
                  .then((session) => {
                        session.getReturnCode().then((returnCode) => {
                              if (ReturnCode.isSuccess(returnCode))
                                {
                                  if (mounted)
                                    {
                                      setState(() {
                                        _inputVideo = outputFile;
                                      }),
                                    }
                                }
                              else if (ReturnCode.isCancel(returnCode))
                                {
                                  {print("Cancelled")}
                                }
                              else
                                {
                                  {print("failed !!")}
                                }
                            })
                      })
                  .whenComplete(() => {
                        print("in complete"),
                      })
            });
    setState(() {
      _inputVideo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Add Video",
        isSubPage: true,
      ),
      body: VideoPlayerScreen(inputVideo: _inputVideo),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            child: FloatingActionButton(
                onPressed: () {},
                heroTag: 'video0',
                backgroundColor: hexStringToColor("#fd9333"),
                tooltip: 'Pick Video from gallery',
                child: const FaIcon(FontAwesomeIcons.photoFilm)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
                backgroundColor: hexStringToColor("#cd2b27"),
                onPressed: () {
                  _videoFromCamera();
                },
                heroTag: 'video1',
                tooltip: 'Take a Video',
                child: const FaIcon(FontAwesomeIcons.video)),
          ),
        ],
      ),
    );
  }
}
