class CarouselItem {
  int id;
  String name;
  CardIconData icon;
  CardColor colors;

  CarouselItem({this.id, this.name, this.icon, this.colors});

  factory CarouselItem.fromJson(Map<String, dynamic> parsedJson) {
    return CarouselItem(
        id: parsedJson['id'],
        name: parsedJson['name'],
        icon: parsedJson['icon'],
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
