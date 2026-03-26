import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import 'package:week9firebase1/data/repositories/artists/artist_repository.dart';
import 'package:week9firebase1/model/artists/artist.dart';
import 'package:week9firebase1/model/songs/RichSong.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
    final ArtistRepository artistRepository;
  AsyncValue<List<RichSong>> songsValue = AsyncValue.loading();
  // AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  // LibraryViewModel({required this.songRepository, required this.playerState}) 
  LibraryViewModel({required this.songRepository, required this.artistRepository, required this.playerState}){
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtist();
      
      final richSongs = songs.map((song) {
        final artist = artists.firstWhere((a) => a.id == song.artistId);
        return RichSong(
          id: song.id,
          title: song.title,
          duration: song.duration,
          artistId: song.artistId,
          artistName: artist.name,
          artistGenre: artist.genre,
          imageUrl: song.imageUrl,
        );
      }).toList();

      songsValue = AsyncValue.success(richSongs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(RichSong song) => playerState.currentSong == song;

 void start(RichSong song) => playerState.start(song);
  void stop(RichSong song) => playerState.stop();
}
