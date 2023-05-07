import 'package:flutter/material.dart';
import 'package:hipspot/model/recommend_page/newly_opened.dart';

import '../../services/remote_service.dart';

class FbNewlyOpened extends StatelessWidget {
  final int rank;

  const FbNewlyOpened({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewlyOpened>?>(
      future: RemoteService().getNewlyOpened(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          // When data is fetched successfully
          List<NewlyOpened>? newlyOpened = snapshot.data;
          return Image.network(newlyOpened![rank].imageUrl[0],
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
