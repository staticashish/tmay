import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmay/utils/colors_utils.dart';
import 'package:video_player/video_player.dart';

import 'package:tmay/custom/custom_evelated_button_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  final XFile? inputVideo;
  const VideoPlayerScreen({Key? key, this.inputVideo}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != _controller.value.isInitialized) {
      initialized = _controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    if (widget.inputVideo != null) {
      if (kIsWeb) {
        _controller = VideoPlayerController.network(widget.inputVideo!.path);
      } else {
        _controller = VideoPlayerController.file(File(widget.inputVideo!.path));
      }
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.addListener(_onVideoControllerUpdate);
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
    print(widget.inputVideo);
    print(initialized);

    if (widget.inputVideo != null) {
      if (kIsWeb) {
        _controller = VideoPlayerController.network(widget.inputVideo!.path);
      } else {
        _controller = VideoPlayerController.file(File(widget.inputVideo!.path));
      }
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.addListener(_onVideoControllerUpdate);
      _controller.setLooping(true);

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_onVideoControllerUpdate);
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(initialized);
    if (initialized) {
      return FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: hexStringToColor("#3a393f"),
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AspectRatio(
                          //aspectRatio: _controller.value.aspectRatio,
                          aspectRatio: 0.8,
                          // Use the VideoPlayer widget to display the video.
                          child: Chewie(controller: _chewieController),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButtonWidget(
                          onPressed: () {}, labelText: "Save Video"),
                    ],
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Text(
                    'Pick image/video error: ${snapshot.error}}',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
            }
          });
    } else {
      return Center(
          child: Text(
        "Please record or select video !!",
        style: TextStyle(
          fontSize: 15,
          color: hexStringToColor("#3a393f"),
          fontWeight: FontWeight.w500,
        ),
      ));
    }
  }
}
