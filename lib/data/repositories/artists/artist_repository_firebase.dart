import 'dart:convert';
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';
import 'package:http/http.dart' as http;



class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.parse(
  'https://myfirstfirebasedatabase-800e7-default-rtdb.asia-southeast1.firebasedatabase.app/artists.json',
);
  @override
  Future<List<Artist>> fetchArtist() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final Map<String, dynamic>? artistsMap = json.decode(response.body);

      if (artistsMap == null) return [];

      return artistsMap.keys.map((key) {
        final data = Map<String, dynamic>.from(artistsMap[key]);
        return ArtistDto.fromJson(key, data);
      }).toList();
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }
}
