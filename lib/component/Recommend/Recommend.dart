import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final String text;
  final String subtext;
  final List<String> list;
  final List<String> cafeName;

  ImageSlider(
      {Key? key, required this.text, required this.subtext, required this.list, required this.cafeName})
      : super(key: key);

  late final List<Widget> imageSliders = list
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
                          cafeName[list.indexOf(item)],
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
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (subtext.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 2),
            child: Text(
              subtext,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff737373),
              ),
            ),
          ),
        const SizedBox(
          height: 8,
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
