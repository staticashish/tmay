import 'dart:io';
import 'dart:typed_data';

import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_full/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_full/return_code.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<Future<FFmpegSession>> addTextOnVideo(
    String inputPath, String outputPath, String questionText) async {
  /*final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
  FlutterFFmpegConfig().setFontDirectory("/assets/fonts", null);*/
  //String? fontPath = "assets/fonts/IcoMoon.ttf";//await _getFontPath();
  FFmpegKitConfig.setFontDirectory("/assets/fonts");

  String? fontPath = await _getFontPath();
  String command = "";
  if (questionText.length < 45) {
    command =
        "-i $inputPath -vf drawtext=text_shaping=1:text='$questionText':fontfile=$fontPath:fontcolor=white:fontsize=30:box=1:boxborderw=5:boxcolor=white@0.25:x=(w-text_w)/2:y=h-th-70:fix_bounds=true -c:a aac -y -movflags +faststart -preset ultrafast $outputPath";
  } else {
    command =
        "-i $inputPath -vf drawtext=text_shaping=1:text='$questionText':fontfile=$fontPath:fontcolor=white:fontsize=50:y=h-line_h-50:x=w-t*300 -c:a aac -y -movflags +faststart -preset ultrafast $outputPath";
  }

  print("formatting $command");
 // return FFmpegKit.executeAsync(command).catchError((e) => print('Error: $e'));
  /*flutterFFmpeg.executeAsync(command, (execution) {
    int executionId = execution.executionId;
    int returnCode = execution.returnCode;
    print("helllo");
    print(
        "FFmpeg process for executionId $executionId exited with rc $returnCode");
  }).whenComplete(() => {

  }).then((executionId) =>
      print("Async FFmpeg process started with executionId $executionId."));
  return outputPath;*/
  /*return FFmpegKit.executeAsync(command, (session) async {
    final returnCode = await session.getReturnCode();

      print("returnCode $returnCode");


    if (ReturnCode.isSuccess(returnCode)) {
      print("success");
    } else if (ReturnCode.isCancel(returnCode)) {
      print("cancelled");
    } else {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();
      final failStackTrace = await session.getFailStackTrace();
      final output = await session.getOutput();
      print(
          "FFmpeg process exited with state $state and rc $returnCode.$failStackTrace with output ${output}");
    }
  }, (log) {
    final message = log.getMessage();
    final sessionId = log.getSessionId();
    print("$message");
  }, (statistics)  {

  }); */
  Future<FFmpegSession> sessionFuture =
      FFmpegKit.execute(command).catchError((e) {
    print('Error: $e');
  });

  return sessionFuture;
  sessionFuture.then((session) => {
        session.getReturnCode().then((returnCode) => {
              if (returnCode != null)
                {print("returnCode ${returnCode!.getValue()}")},
              if (ReturnCode.isSuccess(returnCode))
                {print("success")}
              else if (ReturnCode.isCancel(returnCode))
                {print("cancelled")}
              else
                {
                  print("failed")
                  /*print(
      "FFmpeg process exited with state $state and rc $returnCode.$failStackTrace with output ${output}");*/
                }
            })
      });
}

Future<String> _getFontPath() async {
  var appDir = await getApplicationDocumentsDirectory();
  String? fontPath = "${appDir.path}/IcoMoon.ttf";
  ByteData fontData = await rootBundle.load("assets/fonts/IcoMoon.ttf");
  List<int> fontBytes = fontData.buffer
      .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
  await File(fontPath).writeAsBytes(fontBytes);
  return fontPath;
}
