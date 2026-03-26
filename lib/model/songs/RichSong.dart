class RichSong {
  final String id;
  final String title;
  final Duration duration;
  final String artistId;

  final String artistName;
  final String artistGenre;
  final String imageUrl;

  RichSong({
    required this.id,
    required this.title,
    required this.duration,
    required this.artistId,
    required this.artistName,
    required this.artistGenre,
    required this.imageUrl,
  });
}