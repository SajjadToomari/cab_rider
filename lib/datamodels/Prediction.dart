class Prediction {
  String placeId;
  String mainText;
  String secondaryText;

  Prediction(
      {required this.placeId,
      required this.mainText,
      required this.secondaryText});

// Prediction.fromJson(Map<String, dynamic> json){
//   placeId = json['properties']['osm_id'].toString();
//   mainText = json['properties']['name'].toString();
// }

}
