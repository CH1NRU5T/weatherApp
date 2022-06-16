import 'dart:ui';

List<Color> cloudy = [
  Color(0xff6EFAE6),
  Color(0xff72EFEE),
];

List<Color> rainy = [
  Color(0xff5AE0FF),
  Color(0xff5ACBF9),
];
List<Color> sunny = [
  Color(0xffFEE17F),
  Color(0xffFFBF95),
];

List<Color> getGradient(int id) {
  if (id > 800 && id < 805) {
    return cloudy;
  } else if (id >= 200 && id <= 531) {
    return rainy;
  } else {
    return sunny;
  }
}
