import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/dataprovider/AppData.dart';
import 'package:cab_rider/helpers/HttpClient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  var focusDestination = FocusNode();

  bool focused = false;

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  void searchPlace(String placeName) async {
    String url = 'https://photon.komoot.io/api/?q=$placeName';
    var response = await HttpClient.getRequest(url);

    if (response.status == 200) {}
  }

  @override
  Widget build(BuildContext context) {
    setFocus();

    String address =
        Provider.of<AppData>(context).pickupAddress!.placeName ?? '';
    pickupController.text = address;

    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 220,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7))
          ]),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back)),
                    const Center(
                      child: Text(
                        'Set Destination',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Image.asset(
                      'images/pickicon.png',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextField(
                            controller: pickupController,
                            decoration: const InputDecoration(
                                hintText: 'Pickup Location',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'images/desticon.png',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextField(
                            onChanged: (value) {
                              searchPlace(value);
                            },
                            controller: destinationController,
                            focusNode: focusDestination,
                            decoration: const InputDecoration(
                                hintText: 'Where to?',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
