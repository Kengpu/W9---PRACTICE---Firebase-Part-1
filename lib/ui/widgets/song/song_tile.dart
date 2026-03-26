import 'package:flutter/material.dart';
import 'package:week9firebase1/model/songs/RichSong.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });
  final RichSong song;
  // final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 70,
          child: ListTile(
            onTap: onTap,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(song.imageUrl),
            ),
            title: Text(song.title),
            subtitle: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
                children: [
                  TextSpan(
                    text: "${formatDuration(song.duration)} mins  ",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: "${song.artistName} - ${song.artistGenre}"),
                ],
              ),
            ),
            trailing: Text(
              isPlaying ? "Playing" : "",
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final paddedSeconds = seconds.toString().padLeft(2, '0');
    return '$minutes:$paddedSeconds';
  }
}
