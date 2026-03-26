import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.parse(
  'https://myfirstfirebasedatabase-800e7-default-rtdb.asia-southeast1.firebasedatabase.app/songs.json',
);
  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final Map<String, dynamic>? songsMap = json.decode(response.body);

      if (songsMap == null) return [];

      return songsMap.keys.map((key) {
        final data = Map<String, dynamic>.from(songsMap[key]);
        return SongDto.fromJson(key, data);
      }).toList();
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final songs = await fetchSongs();
    try {
      return songs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }
}
