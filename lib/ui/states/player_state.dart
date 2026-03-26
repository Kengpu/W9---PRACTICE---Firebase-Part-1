import 'package:flutter/widgets.dart';
import 'package:week9firebase1/model/songs/RichSong.dart';

class PlayerState extends ChangeNotifier {
  RichSong? _currentSong;

  RichSong? get currentSong => _currentSong;

  void start(RichSong song) {
    _currentSong = song;

    notifyListeners();
  }

  void stop() {
    _currentSong = null;

    notifyListeners();
  }
}
