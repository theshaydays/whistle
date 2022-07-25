class Song {
  final String songName;
  final String artist;
  final String image;
  final int id;

  Song(
      {required this.id,
      required this.songName,
      required this.artist,
      required this.image});
}

List<Song> songs = [
  Song(
      id: 1,
      songName: 'Happy Birthday',
      image: "images/beach photo.jpg",
      artist: 'Whistle'),
  Song(
      id: 2,
      songName: 'Jingle Bells',
      image: "images/flowers.jpg",
      artist: 'Whistle'),
  Song(
      id: 3,
      songName: 'Ode to Joy',
      image: "images/mountain.jpeg",
      artist: 'Whistle'),
  Song(
      id: 4,
      songName: 'Saints Go Marching On',
      image: "images/sky.jpeg",
      artist: 'Whistle'),
];
