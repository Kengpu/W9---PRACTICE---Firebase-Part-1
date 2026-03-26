import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9firebase1/data/repositories/artists/artist_repository.dart';
import 'package:week9firebase1/ui/screens/library/view_model/artist_view_model.dart';
import 'package:week9firebase1/ui/screens/library/widgets/artists_content.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistViewModel(
        artistRepository: context.read<ArtistRepository>(),
      ),
      child: ArtistsContent(),
    );
  }
}