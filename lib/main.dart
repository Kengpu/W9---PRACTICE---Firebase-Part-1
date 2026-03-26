import 'package:flutter/material.dart';
import 'package:week9firebase1/data/repositories/songs/song_repository_firebase.dart';
import 'model/songs/song.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SongRepositoryFirebase songRepo = SongRepositoryFirebase();

  await loadSongs(songRepo);
}

Future<void> loadSongs(SongRepositoryFirebase repo) async {
  try {
    List<Song> songList = await repo.fetchSongs();

    print('Total songs: ${songList.length}');
    
    for (var item in songList) {
      print(item);
    }
  } catch (error) {
    print('Failed to load songs: $error');
  }
}