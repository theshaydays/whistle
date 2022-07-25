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
    playlistName: 'Ode to Joy',
    image: "images/mountain.jpeg",
  ),
  Playlist(
    id: 4,
    playlistName: 'Saints Go Marching On',
    image: "images/sky.jpeg",
  ),
];

var playlistInfo = {
  'Happy Birthday': ['audio/HappyBdayXylophone.mp3', '48', happyBday, 50],
  'Jingle Bells': ['audio/JingleBellsXylophone.mp3', '65', jingleBells, 80],
  'Ode to Joy': ['audio/OdeToJoyXylophone.mp3', '73', odeToPain, 70],
  'Saints Go Marching On': [
    'audio/SaintsGoMarchingOnXylophone.mp3',
    '58',
    saints,
    80
  ],
};
