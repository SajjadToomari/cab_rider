import 'dart:async';

import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/widgets/BrandDivider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Main Page')),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
            },
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 240,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15)
                      , topRight: Radius.circular(15)),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7)
                  )]
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        const Text('Nice to see you!', style: TextStyle(fontSize: 10),),
                        const Text('Where are you going?', style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),),

                        const SizedBox(height: 20,),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7)
                              )],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: const [
                                Icon(Icons.search,color: Colors.blueAccent),
                                SizedBox(width: 10,),
                                Text('Search Destination')
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22,),

                        Row(
                          children: [
                            const Icon(OMIcons.home, color: BrandColors.colorDimText),
                            const SizedBox(width: 12,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Add Home'),
                                SizedBox(height: 3),
                                Text('Your residential address',
                                style: TextStyle(fontSize: 11, color: BrandColors.colorDimText),)
                              ],
                            )

                          ],
                        ),

                        const SizedBox(height: 10,),

                        const BrandDivider(),

                        const SizedBox(height: 16,),

                        Row(
                          children: [
                            const Icon(OMIcons.workOutline, color: BrandColors.colorDimText),
                            const SizedBox(width: 12,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Add Work'),
                                SizedBox(height: 3),
                                Text('Your office address',
                                  style: TextStyle(fontSize: 11, color: BrandColors.colorDimText),)
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
