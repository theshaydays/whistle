import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'PlayButton.dart';

class StaticPlayer extends StatefulWidget {
  final String filePath;

  const StaticPlayer(this.filePath);

  @override
  _StaticPlayerState createState() => _StaticPlayerState();
}

class _StaticPlayerState extends State<StaticPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setAsset(widget.filePath);
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
