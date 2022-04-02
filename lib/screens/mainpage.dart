import 'dart:async';

import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/dataprovider/AppData.dart';
import 'package:cab_rider/helpers/MapHelper.dart';
import 'package:cab_rider/helpers/PlatformInfo.dart';
import 'package:cab_rider/screens/searchpage.dart';
import 'package:cab_rider/styles/styles.dart';
import 'package:cab_rider/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  double searchSheetHeight =
      PlatformInfo().getCurrentPlatformType() == PlatformType.iOS ? 300 : 270;
  double mapBottomPadding = 0;

  Position? currentPosition;

  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  void setupPositionLocator() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    controller.goToLocation(GeoPoint(
        latitude: currentPosition!.latitude,
        longitude: currentPosition!.longitude));

    String address =
        await MapHelper.findCoordinateAddress(currentPosition!, context);
    print(address);
    // LatLng pos = LatLng(currentPosition!.latitude, currentPosition!.longitude);
    // CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    // mapController!.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Container(
                color: Colors.white,
                height: 160,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/user_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Sajjad',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Brand-Bold',
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text('View Profile')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const BrandDivider(),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(OMIcons.cardGiftcard),
                title: Text(
                  'Free Rides',
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(OMIcons.creditCard),
                title: Text(
                  'Payments',
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(OMIcons.history),
                title: Text(
                  'Ride History',
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(OMIcons.contactSupport),
                title: Text(
                  'Support',
                  style: kDrawerItemStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            trackMyPosition: false,
            initZoom: 12,
            stepZoom: 1.0,
            androidHotReloadSupport: true,
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: RoadConfiguration(
              startIcon: const MarkerIcon(
                icon: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.brown,
                ),
              ),
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )),
            onMapIsReady: (e) {
              setupPositionLocator();
            },
          ),
          // GoogleMap(
          //   padding: EdgeInsets.only(bottom: mapBottomPadding),
          //   mapType: MapType.normal,
          //   myLocationButtonEnabled: true,
          //   initialCameraPosition: _kGooglePlex,
          //   myLocationEnabled: true,
          //   zoomGesturesEnabled: true,
          //   zoomControlsEnabled: true,
          //   onMapCreated: (GoogleMapController controller) {
          //     _controller.complete(controller);
          //     mapController = controller;
          //
          //     setState(() {
          //       mapBottomPadding = PlatformInfo().getCurrentPlatformType() ==
          //               PlatformType.Android
          //           ? 280
          //           : 270;
          //     });
          //
          //     setupPositionLocator();
          //   },
          // ),
          Positioned(
            top: 44,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.menu, color: Colors.black87),
                ),
              ),
            ),
          ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: searchSheetHeight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Nice to see you!',
                          style: TextStyle(fontSize: 10),
                        ),
                        const Text(
                          'Where are you going?',
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7, 0.7))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Icon(Icons.search, color: Colors.blueAccent),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Search Destination')
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            const Icon(OMIcons.home,
                                color: BrandColors.colorDimText),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .pickupAddress ==
                                        null
                                    ? "Add Home"
                                    : Provider.of<AppData>(context,
                                            listen: false)
                                        .pickupAddress!
                                        .placeName),
                                const SizedBox(height: 3),
                                const Text(
                                  'Your residential address',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: BrandColors.colorDimText),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const BrandDivider(),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const Icon(OMIcons.workOutline,
                                color: BrandColors.colorDimText),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Add Work'),
                                SizedBox(height: 3),
                                Text(
                                  'Your office address',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: BrandColors.colorDimText),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
