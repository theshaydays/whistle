import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'PlayButton.dart';

class StaticPlayer extends StatefulWidget {
  final String filePath;
  final String pathType;

  const StaticPlayer(this.filePath, this.pathType);

  @override
  _StaticPlayerState createState() => _StaticPlayerState();
}

class _StaticPlayerState extends State<StaticPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.pathType == 'asset') {
      _audioPlayer.setAsset(widget.filePath);
    } else if (widget.pathType == 'device file') {
      _audioPlayer.setFilePath(widget.filePath);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayButton(_audioPlayer);
  }
}
