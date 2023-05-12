import 'package:flutter/material.dart';
import 'package:hipspot/component/Favorite/favorite_card.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/model/favorite_card_model.dart';

class FavoriteList extends StatelessWidget {
  final List<FavoriteCardModel> favoriteList;
  const FavoriteList({super.key, required this.favoriteList});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: FontFamily.pretendard.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("즐겨찾기", style: defaultTextStyle.copyWith(fontSize: 20)),
        const SizedBox(height: 20),
        Expanded(
          child: favoriteList.isEmpty
              ? const Center(child: Text("즐겨찾기한 카페가 없습니다."))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 32,
                      childAspectRatio: 166 / (166 + 8 + 24)),
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    return FavofiteCard(
                        title: favoriteList[index].title,
                        imageUrl: favoriteList[index].imageUrl,
                        isBookmarked: favoriteList[index].isBookmarked);
                  }),
        )
      ],
    );
  }
}
