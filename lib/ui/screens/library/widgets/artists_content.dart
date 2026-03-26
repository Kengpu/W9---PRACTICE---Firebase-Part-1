import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9firebase1/model/artists/artist.dart';
import 'package:week9firebase1/ui/screens/library/view_model/artist_view_model.dart';
import 'package:week9firebase1/ui/theme/theme.dart';
import 'package:week9firebase1/ui/utils/async_value.dart';
import 'package:week9firebase1/ui/widgets/artist/artist_tile.dart';

class ArtistsContent extends StatefulWidget {
  const ArtistsContent({super.key});

  @override
  State<ArtistsContent> createState() => _ArtistsContentState();
}

class _ArtistsContentState extends State<ArtistsContent> {
  @override
  Widget build(BuildContext context) {
    ArtistViewModel mv = context.watch<ArtistViewModel>();

    AsyncValue<List<Artist>> asyncValue = mv.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) => ArtistTile(
            artist: artists[index],
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artists", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}