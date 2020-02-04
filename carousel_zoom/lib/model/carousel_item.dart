class CarouselItem {
  int id;
  String name;
  CardIconData iconData;
  CardColor colors;

  CarouselItem({this.id, this.name, this.iconData, this.colors});

  factory CarouselItem.fromJson(Map<String, dynamic> parsedJson) {
    return CarouselItem(
        id: parsedJson['id'],
        name: parsedJson['name'],
        iconData: parsedJson['iconData'],
        colors: parsedJson['colors']);
  }
}

class CardIconData {
  String codePoint;
  String fontFamily;

  CardIconData({this.codePoint, this.fontFamily});
}

class CardColor {
  String card;
  String icon;
  String iconCircle;
  String name;

  CardColor({this.card, this.icon, this.iconCircle, this.name});
}
