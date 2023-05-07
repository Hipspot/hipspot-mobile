import 'package:flutter/material.dart';
import 'package:hipspot/model/recommend_page/high_rated.dart';

import '../../services/remote_service.dart';

class FbHighRated extends StatelessWidget {
  final int rank;

  const FbHighRated({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HighRated>?>(
      future: RemoteService().getHighRated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          // When data is fetched successfully
          List<HighRated>? highRated = snapshot.data;
          return Image.network(highRated![rank].imageUrl[0],
              width: 280, height: 416, fit: BoxFit.fill);
        } else {
          // When there is an error fetching data
          return const Center(
            child: Text('Error fetching data.'),
          );
        }
      },
    );
  }
}
