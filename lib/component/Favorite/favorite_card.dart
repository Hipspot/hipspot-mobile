import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class FavofiteCard extends StatelessWidget {
  final bool isBookmarked;
  final String title;
  final String imageUrl;
  const FavofiteCard(
      {super.key,
      required this.isBookmarked,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: FontFamily.pretendard.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(imageUrl)),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: isBookmarked
                        ? SvgPicture.asset(IconAsset.starFilled.path)
                        : SvgPicture.asset(IconAsset.starOutlined.path)),
              )),
        ),
        const SizedBox(height: 8),
        Text(title, style: defaultTextStyle),
      ],
    );
  }
}
