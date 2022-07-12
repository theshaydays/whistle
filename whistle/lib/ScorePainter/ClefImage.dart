import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'Clef.dart';
import 'ClefPainter.dart';
import 'NoteRange.dart';

class ClefImage extends StatelessWidget {
  final Size size;
  final Clef clef;
  final NoteRange noteRange;
  final NoteRange noteRangeToClip;
  final List<NoteImage> noteImages;
  final Color clefColor;
  final Color noteColor;

  const ClefImage({
    Key? key,
    required this.clef,
    required this.noteRange,
    required this.noteImages,
    required this.clefColor,
    required this.noteColor,
    this.size = Size.zero,
    NoteRange? noteRangeToClip,
  })  : this.noteRangeToClip = noteRangeToClip ?? noteRange,
        super(key: key);

  @override
  Widget build(BuildContext context) => ClipRect(
          child: CustomPaint(
        painter: ClefPainter(
          clef: clef,
          clefColor: clefColor,
          noteColor: noteColor,
          noteRange: noteRange,
          noteRangeToClip: noteRangeToClip,
          lineHeight: 1,
          noteImages: noteImages,
        ),
        size: size,
      ));
}
