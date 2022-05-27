import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whistle/models/constants.dart';

class PlayButton extends StatelessWidget {
  final AudioPlayer _audioPlayer;

  const PlayButton(this._audioPlayer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<PlayerState>(
      stream: _audioPlayer.playerStateStream,
      builder: (_, snapshot) {
        final playerState = snapshot.data;
        return _playPauseButton(playerState!, size.width);
      },
    );
  }

  Widget _playPauseButton(PlayerState playerState, size) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 0.17 * size,
        height: 0.17 * size,
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    } else if (_audioPlayer.playing != true) {
      return IconButton(
        icon: Icon(Icons.play_arrow),
        iconSize: 0.17 * size,
        onPressed: _audioPlayer.play,
        color: kPrimaryColor,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: Icon(Icons.pause),
        iconSize: 0.17 * size,
        onPressed: _audioPlayer.pause,
        color: kPrimaryColor,
      );
    }
    return IconButton(
      icon: Icon(Icons.replay),
      iconSize: 64.0,
      onPressed: () => _audioPlayer.seek(Duration.zero,
          index: _audioPlayer.effectiveIndices?.first),
      color: kPrimaryColor,
    );
  }
}
