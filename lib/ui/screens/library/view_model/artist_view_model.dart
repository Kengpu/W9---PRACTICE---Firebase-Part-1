import 'package:flutter/material.dart';
import 'package:week9firebase1/data/repositories/artists/artist_repository.dart';
import 'package:week9firebase1/model/artists/artist.dart';
import 'package:week9firebase1/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  Future<void> fetchArtists() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final artists = await artistRepository.fetchArtist();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      artistsValue = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }
}