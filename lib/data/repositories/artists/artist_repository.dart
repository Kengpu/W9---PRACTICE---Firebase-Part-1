import 'package:week9firebase1/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtist();
}