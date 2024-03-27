import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  setLatLng(double lat, double lng) async {
    var cache = await SharedPreferences.getInstance();
    cache.setString('LatLng', '$lat,$lng');
  }

  Future<List<String>> getLatLng() async {
    var cache = await SharedPreferences.getInstance();
    return cache.getString('LatLng')?.split(',') ?? [];
  }
}
