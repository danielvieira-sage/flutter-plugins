library carousel_zoom;

import 'package:flutter/material.dart';
import 'package:carousel_zoom/model/carousel_item.dart';

const double _kViewportFraction = 0.5;

class Carousel extends StatefulWidget {
  final Function(int) onChanged;
  List<CarouselItem> listItens;

  Carousel({this.listItens, this.onChanged});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _backgroundPageController = PageController();
  final PageController _pageController =
      PageController(viewportFraction: _kViewportFraction);
  ValueNotifier<double> selectedIndex = ValueNotifier<double>(0.0);

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  bool _handlePageNotification(ScrollNotification notification,
      PageController leader, PageController follower) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      selectedIndex.value = leader.page;
      if (follower.page != leader.page) {
        follower.position.jumpTo(leader.position.pixels /
            _kViewportFraction); // ignore: deprecated_member_use
      }

      if (isInteger(selectedIndex.value) && widget.onChanged != null) {
        widget.onChanged(selectedIndex.value.round());
      }
      setState(() {});
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _backgroundPageController,
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              return _handlePageNotification(
                  notification, _pageController, _backgroundPageController);
            },
            child: PageView(
              controller: _pageController,
              children: _buildPages(),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _buildPages() {
    final List<Widget> pages = <Widget>[];
    for (int index = 0; index < widget.listItens.length; index++) {
      var alignment = Alignment.center.add(
          Alignment((selectedIndex.value - index) * _kViewportFraction, 0.0));
      var resizeFactor =
          (1 - (((selectedIndex.value - index).abs() * 0.3).clamp(0.0, 1.0)));
      pages.add(
        Container(
          alignment: alignment,
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 65 * resizeFactor,
                          height: 65 * resizeFactor,
                          child: Icon(
                            (widget.listItens[index].iconData != null &&
                                    widget.listItens[index].iconData
                                            .codePoint !=
                                        null &&
                                    widget.listItens[index].iconData
                                            .fontFamily !=
                                        null)
                                ? IconData(
                                    int.parse("0xff" +
                                        widget.listItens[index].iconData
                                            .codePoint),
                                    fontFamily: widget
                                        .listItens[index].iconData.fontFamily)
                                : Icon(Icons.add_box),
                            color: (widget.listItens[index].colors != null &&
                                    widget.listItens[index].colors.icon != null)
                                ? Color(
                                    int.parse("0xff" +
                                        widget.listItens[index].colors.icon),
                                  )
                                : Color.fromRGBO(0, 219, 1, 1),
                            size: 45.0 * resizeFactor,
                          ),
                          decoration: BoxDecoration(
                            color: (widget.listItens[index].colors != null &&
                                    widget.listItens[index].colors.iconCircle !=
                                        null)
                                ? Color(
                                    int.parse("0xff" +
                                        widget.listItens[index].colors
                                            .iconCircle),
                                  )
                                : Color.fromRGBO(2, 51, 75, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.listItens[index].name,
                          style: TextStyle(
                              fontSize: 17 * resizeFactor,
                              color: (widget.listItens[index].colors != null &&
                                      widget.listItens[index].colors.name !=
                                          null)
                                  ? Color(
                                      int.parse("0xff" +
                                          widget.listItens[index].colors.name),
                                    )
                                  : Color.fromRGBO(104, 104, 104, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(207, 207, 207, 1),
                        blurRadius: 25.0,
                        spreadRadius: 5.0,
                        offset: Offset(10.0, 25.0),
                      ),
                    ],
                    color: (widget.listItens[index].colors != null &&
                            widget.listItens[index].colors.card != null)
                        ? Color(
                            int.parse(
                                "0xff" + widget.listItens[index].colors.card),
                          )
                        : Colors.white,
                  ),
                  margin: EdgeInsets.all(5),
                  height: 120.0 * resizeFactor,
                  width: 220.0 * resizeFactor,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return pages;
  }
}
