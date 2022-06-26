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
    playlistName: 'Sample 1',
    image: "images/beach photo.jpg",
  ),
  Playlist(
    id: 2,
    playlistName: 'Sample 2',
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
