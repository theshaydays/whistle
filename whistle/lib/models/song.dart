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
      songName: 'Sample 1',
      image: "images/beach photo.jpg",
      artist: 'Whistle'),
  Song(
      id: 2,
      songName: 'Sample 2',
      image: "images/flowers.jpg",
      artist: 'Whistle'),
  Song(
      id: 3,
      songName: 'Sample 3',
      image: "images/mountain.jpeg",
      artist: 'Whistle'),
  Song(
      id: 4, songName: 'Sample 4', image: "images/sky.jpeg", artist: 'Whistle'),
];
