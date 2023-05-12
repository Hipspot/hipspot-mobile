import 'package:flutter/material.dart';

import '../../model/recommend_page/closest.dart';
import '../../services/remote_service.dart';

class FbClosest extends StatelessWidget {
  final int rank;

  const FbClosest({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Closest>?>(
      future: RemoteService().getClosest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          // When data is fetched successfully
          List<Closest>? closest = snapshot.data;
          return Image.network(closest![rank].imageUrl[0],
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
