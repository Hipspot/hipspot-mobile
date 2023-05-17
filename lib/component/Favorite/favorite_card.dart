import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class FavoriteCard extends StatelessWidget {
  final bool isBookmarked;
  final String cafeId;
  final String cafeName;
  final String thumbNail;
  final Future<void> Function(String, bool) onTapCard;
  const FavoriteCard(
      {super.key,
      required this.cafeId,
      required this.isBookmarked,
      required this.cafeName,
      required this.thumbNail,
      required this.onTapCard});

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
                      fit: BoxFit.cover, image: NetworkImage(thumbNail)),
                ),
                child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () async {
                        await onTapCard(cafeId, isBookmarked);
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: isBookmarked
                              ? SvgPicture.asset(IconAsset.starFilled.path)
                              : SvgPicture.asset(IconAsset.starOutlined.path)),
                    )))),
        const SizedBox(height: 8),
        Text(cafeName, style: defaultTextStyle),
      ],
    );
  }
}
