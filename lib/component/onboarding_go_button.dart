import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/duration.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class GoButton extends StatefulWidget {
  const GoButton(
      {super.key,
      required this.selectedFilter,
      required this.beforeSelectedFilter});
  final String go = "GO!";
  final double buttonHeightRatio = 119 / 812;
  final FilterListEnum selectedFilter;
  final FilterListEnum beforeSelectedFilter;
  @override
  State<GoButton> createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: filterTextDuration,
      vsync: this,
    );
    _color = ColorTween(
            begin: widget.beforeSelectedFilter.color,
            end: widget.selectedFilter.color)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void didUpdateWidget(oldWiget) {
    super.didUpdateWidget(oldWiget);
    _controller.value = 0;
    _color = ColorTween(
            begin: widget.beforeSelectedFilter.color,
            end: widget.selectedFilter.color)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => {print("tapped")},
        child: AnimatedBuilder(
            animation: _color,
            builder: (context, child) => Container(
                height: MediaQuery.of(context).size.height *
                    widget.buttonHeightRatio,
                decoration: BoxDecoration(color: _color.value),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 24, 0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.go,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: blackColor,
                                  fontFamily: FontFamily.pretendard.name,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -2)),
                          SizedBox(
                              height: 40,
                              child: Row(children: [
                                SvgPicture.asset(IconAsset.longArrow.path,
                                    fit: BoxFit.none),
                              ]))
                        ])))));
  }
}
