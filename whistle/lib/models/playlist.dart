class Playlist {
  final String playlistName;
  final String image;
  final int id;

  Playlist({required this.id, required this.playlistName, required this.image});
}

List<Playlist> playlists = [
  Playlist(
    id: 1,
    playlistName: 'Sample 1',
    image: "images/whistle.jpg",
  ),
  Playlist(
    id: 2,
    playlistName: 'Sample 2',
    image: "images/sample1.jpg",
  ),
  Playlist(
    id: 3,
    playlistName: 'Sample 3',
    image: "images/sample2.jpg",
  )
];
