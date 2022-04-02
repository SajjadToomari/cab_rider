import 'package:cab_rider/datamodels/Address.dart';
import 'package:cab_rider/dataprovider/AppData.dart';
import 'package:cab_rider/helpers/HttpClient.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapHelper {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    // String url = 'https://nominatim.openstreetmap.org/search?format=jsonv2&q=test'
    String url =
        'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=jsonv2';

    var response = await HttpClient.getRequest(url);
    if (response.status == 200) {
      Address pickupAddress = Address(
          placeId: response.content['place_id'].toString(),
          latitude: double.parse(response.content['lat']),
          longitude: double.parse(response.content['lon']),
          placeName: response.content['display_name'],
          placeFormattedAddress: response.content['display_name']);

      Provider.of<AppData>(context, listen: false)
          .updatePickupAddress(pickupAddress);

      return response.content['display_name'];
    } else {
      return '';
    }
  }
}
