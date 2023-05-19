import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Recommend extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> cafeImageUrlList;
  final List<String> cafeName;

  Recommend(
      {Key? key, required this.title, required this.subtitle, required this.cafeImageUrlList, required this.cafeName})
      : super(key: key);

  late final List<Widget> imageSliders = cafeImageUrlList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item,
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
                        child: Text(
                          cafeName[cafeImageUrlList.indexOf(item)],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
