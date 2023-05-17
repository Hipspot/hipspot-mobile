import 'package:flutter/material.dart';
import 'package:hipspot/model/recommend_page/high_rated.dart';
import 'package:hipspot/model/recommend_page/newly_opened.dart';

class FbImage extends StatelessWidget {
  final int rank;
  final Future<List<dynamic>?> Function() remoteServiceCall;

  const FbImage(
      {super.key, required this.rank, required this.remoteServiceCall});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>?>(
      future: remoteServiceCall(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          // When data is fetched successfully
          List<dynamic>? data = snapshot.data;
          if (data is List<HighRated>) {
            return Image.network(data[rank].imageUrl[0],
                width: 280, height: 416, fit: BoxFit.fill);
          } else if (data is List<NewlyOpened>) {
            return Image.network(data[rank].imageUrl[0],
                width: 280, height: 416, fit: BoxFit.fill);
          } else {
            return const Center(
              child: Text('Invalid data type.'),
            );
          }
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
