import 'package:whistle/models/AlgoTestingNotes.dart';

class Playlist {
  final String playlistName;
  final String image;
  final int id;

  Playlist({
    required this.id,
    required this.playlistName,
    required this.image,
  });
}

List<Playlist> playlists = [
  Playlist(
    id: 1,
    playlistName: 'Happy Birthday',
    image: "images/beach photo.jpg",
  ),
  Playlist(
    id: 2,
    playlistName: 'Jingle Bells',
    image: "images/flowers.jpg",
  ),
  Playlist(
    id: 3,
    playlistName: 'Sample 3',
    image: "images/mountain.jpeg",
  ),
  Playlist(
    id: 4,
    playlistName: 'Sample 4',
    image: "images/sky.jpeg",
  ),
];

var playlistInfo = {
  'Happy Birthday': ['audio/HappyBdayXylophone.mp3', '48', happyBday, 50],
  'Jingle Bells': ['audio/JingleBellsXylophone.mp3', '65', jingleBells, 80]
};
