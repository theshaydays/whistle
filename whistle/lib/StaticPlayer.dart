import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'PlayButton.dart';

class StaticPlayer extends StatefulWidget {
  @override
  _StaticPlayerState createState() => _StaticPlayerState();
}

class _StaticPlayerState extends State<StaticPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAsset('whistle/audio/royalty.mp3');
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
