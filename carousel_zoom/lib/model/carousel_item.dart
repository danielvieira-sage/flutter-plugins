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
        iconData: CardIconData.fromJson(parsedJson['iconData']),
        colors: CardColor.fromJson(parsedJson['colors']));
  }
}

class CardIconData {
  String codePoint;
  String fontFamily;

  CardIconData({this.codePoint, this.fontFamily});

  factory CardIconData.fromJson(Map<String, dynamic> parsedJson) {
    return CardIconData(
        codePoint: parsedJson['codePoint'],
        fontFamily: parsedJson['fontFamily']);
  }
}

class CardColor {
  String card;
  String icon;
  String iconCircle;
  String name;

  CardColor({this.card, this.icon, this.iconCircle, this.name});

  factory CardColor.fromJson(Map<String, dynamic> parsedJson) {
    return CardColor(
      card: parsedJson['card'],
      icon: parsedJson['icon'],
      iconCircle: parsedJson["iconCircle"],
      name: parsedJson["name"],
    );
  }
}
