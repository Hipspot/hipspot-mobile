import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../const/recommend_title_text_enum.dart';

class Recommend extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<dynamic>? listType;

  Recommend({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.listType,
  }) : super(key: key);

  late final List<Widget> imageSliders = listType!
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item.imageUrl[0],
                        width: 280, height: 416, fit: BoxFit.fill),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.cafeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                if (subtitle == RecommendTitleTextEnum.highRatedSubTitle.toString()) ...[
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    item.star.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ] else ...[
                                  const Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${item.distance.round().toString()}m',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // column 활용
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 0, 2),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 2),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff737373),
              ),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 416,
              viewportFraction: 0.74,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: false,
              padEnds: false),
          items: imageSliders,
        ),
      ],
    );
  }
}
