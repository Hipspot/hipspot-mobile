import 'package:flutter/material.dart';
import 'package:hipspot/component/Favorite/favorite_card.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/model/favorite_card_model.dart';
import 'package:hipspot/utils/api/favorite.dart';
import 'package:hipspot/utils/authenticate.dart';

class FavoriteListWidget extends StatefulWidget {
  const FavoriteListWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteListWidget> createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {
  List<FavoriteCardModel>? favoriteList;

  @override
  void initState() {
    super.initState();
    fetchData(); // Assuming you have a method to load the favorite list
  }

  Future<void> fetchData() async {
    try {
      final response = await FavoriteApi().getList();
      if (response.statusCode == 200) {
        setState(() {
          var fetchedData = response.data;
          List<dynamic> fetchedFavoriteList = fetchedData['favoriteList'];
          favoriteList = fetchedFavoriteList.isEmpty
              ? []
              : fetchedFavoriteList
                  .map((item) => FavoriteCardModel.fromJson(item))
                  .toList();
        });
      }
    } catch (e) {
      print('Failed to load data, $e');
      showLoginModal(context);
    }
  }

  Future<void> toggleFavorite(String cafeId, bool isBookmarked) async {
    try {
      await FavoriteApi().toggle(cafeId, isBookmarked);
      setState(() {
        favoriteList = favoriteList?.map((favoriteCardState) {
          if (favoriteCardState.cafeId == cafeId) {
            return FavoriteCardModel(
              cafeName: favoriteCardState.cafeName,
              cafeId: favoriteCardState.cafeId,
              thumbNail: favoriteCardState.thumbNail,
              isBookmarked: !favoriteCardState
                  .isBookmarked, // Toggle the isBookmarked value
            );
          }
          return favoriteCardState;
        }).toList();
      });
    } catch (e) {
      print(e);
      showLoginModal(context);
    }
  }

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
          child: favoriteList?.isEmpty ?? true
              ? const Center(child: Text("즐겨찾기한 카페가 없습니다."))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 32,
                      childAspectRatio: 166 / (166 + 8 + 24)),
                  itemCount: favoriteList!.length,
                  itemBuilder: (context, index) {
                    return FavoriteCard(
                        cafeName: favoriteList![index].cafeName,
                        cafeId: favoriteList![index].cafeId,
                        thumbNail: favoriteList![index].thumbNail,
                        isBookmarked: favoriteList![index].isBookmarked,
                        onTapCard: toggleFavorite);
                  }),
        )
      ],
    );
  }
}
