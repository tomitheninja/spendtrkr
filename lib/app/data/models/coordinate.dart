// gps coordinate
class Coordinate {
  final double lat;
  final double lng;
  Coordinate({required this.lat, required this.lng});

  static Coordinate? tryFomList(List<double>? list) {
    try {
      return Coordinate(lat: list![0], lng: list[1]);
    } catch (_) {
      return null;
    }
  }

  List<double> toJson() {
    return [lat, lng];
  }
}
