import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double lng;
  const MapScreen({super.key, required this.lat, required this.lng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController searchController = TextEditingController();
  late GoogleMapController mapController;
  late LatLng initialLocation;
  FocusNode focusNode = FocusNode();

  late double latitude;
  late double longitude = 0;

  setLocation(double lat, double lng) {
    setState(() {
      initialLocation = LatLng(lat, lng);
    });
  }

  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    _addMarker(
      initialLocation,
      "My Marker",
      "Marker description",
    );
  }

  void _addMarker(LatLng position, String markerId, String markerTitle,
      {bool onTapped = false}) {
    // setState(() {
    //   focusNode.unfocus();
    //   _markers = {};
    // });
    // if (!onTapped) {
    //   _getAddressFromLatLng(position.latitude, position.longitude);
    // }
    // Marker marker = Marker(
    //   draggable: true,
    //   markerId: MarkerId(markerId),
    //   position: position,
    //   onDragEnd: (value) {
    //     setState(() {
    //       _addMarker(value, '', '');
    //       latitude = value.latitude;
    //       longitude = value.longitude;
    //     });
    //   },
    //   infoWindow: InfoWindow(
    //     title: markerTitle,
    //   ),
    // );
    // mapController.animateCamera(CameraUpdate.newLatLngZoom(
    //     LatLng(position.latitude, position.longitude), 14));
    //
    // setState(() {
    //   _markers.add(marker);
    //   latitude = position.latitude;
    //   longitude = position.longitude;
    // });
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      await placemarkFromCoordinates(
        lat,
        lng,
      ).then((List<Placemark> placemarks) {
        print("====$placemarks");
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String name = place.name ?? '';
          String subLocality = place.subLocality ?? '';
          String locality = place.locality ?? '';
          String administrativeArea = place.administrativeArea ?? '';
          String postalCode = place.postalCode ?? '';
          String country = place.country ?? '';
          String address =
              "$name${subLocality.isNotEmpty ? ', $subLocality' : ''}${locality.isNotEmpty ? ', $locality' : ''}${administrativeArea.isNotEmpty ? ', $administrativeArea' : ''}${postalCode.isNotEmpty ? ', $postalCode' : ''}${country.isNotEmpty ? ', $country' : ''}";

          setState(() {
            searchController.text = address;
          });
        } else {}
      }).catchError((e) {
        debugPrint(e.toString());
      });
    } catch (e) {}
  }

  onCamerMove(CameraPosition position) async {
    print(position.zoom);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.target.latitude, position.target.longitude);

    Placemark place = placemarks[0];
    String name = place.name ?? '';
    String subLocality = place.subLocality ?? '';
    String locality = place.locality ?? '';
    String administrativeArea = place.administrativeArea ?? '';
    String postalCode = place.postalCode ?? '';
    String country = place.country ?? '';
    String address =
        "$name${subLocality.isNotEmpty ? ', $subLocality' : ''}${locality.isNotEmpty ? ', $locality' : ''}${administrativeArea.isNotEmpty ? ', $administrativeArea' : ''}${postalCode.isNotEmpty ? ', $postalCode' : ''}${country.isNotEmpty ? ', $country' : ''}";
    setState(() {
      searchController.text = address;
    });
    _addMarker(LatLng(position.target.latitude, position.target.longitude),"My Marker",
      "Marker description",);
  }

  @override
  void initState() {
    super.initState();
    latitude = widget.lat;
    longitude = widget.lng;
    setLocation(widget.lat, widget.lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            compassEnabled: true,

            myLocationButtonEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference(17, 26),
            myLocationEnabled: true,
            mapType: MapType.normal,
            trafficEnabled: true,
            zoomGesturesEnabled: true,
            buildingsEnabled: false,
            onCameraMove:onCamerMove,
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 14,
            ),

            onMapCreated: _onMapCreated,
            // markers: _markers,
            onTap: (value) {
              // _addMarker(value, "My Marker", "Marker description");
            },
            // ToDO: add markers
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 36.0),
                child: Image.asset(
                  'assets/images/map_pin.png',
                  height: 36,
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: GooglePlacesAutoCompleteTextFormField(
                focusNode: focusNode,

                decoration: InputDecoration(
                    fillColor: appColors.appWhite,
                    filled: true,
                    hintText: 'Type to search',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )),
                maxLines: 1,
                textEditingController: searchController,
                googleAPIKey: "AIzaSyBObJitjMo7f-b9SyHZMqv0SKmWlQIq0Ak",
                debounceTime: 400,
                countries: const ["IN"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (prediction) {
                  print("Coordinates: (${prediction.lat},${prediction.lng})");
                  setState(() {
                    latitude = double.tryParse(prediction.lat ?? '0') ?? 0;
                    longitude = double.tryParse(prediction.lng ?? '0') ?? 0;
                  });
                  _addMarker(
                      LatLng(double.tryParse(prediction.lat ?? '0') ?? 0,
                          double.tryParse(prediction.lng ?? '0') ?? 0),
                      '',
                      '',
                      onTapped: true);
                },
                itmClick: (prediction) {
                  searchController.text = prediction.description ?? '';
                  searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description!.length));
                }),
          ),
          Positioned(
            bottom: 30,
            child: AppButton(
              radius: 8,
              onPressed: () {
                Navigator.pop(context, {
                  'address': searchController.text,
                  'latitude': latitude,
                  'longitude': longitude,
                });
              },
              title: 'Set Location',
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectLocationFromMap extends StatelessWidget {
//   SelectLocationFromMap({super.key, required this.lat,required this.long});
//   final double lat;
//   final double long;
//   HomePageController homePageController=Get.put(HomePageController());
//   @override
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//       child: Scaffold(
//           endDrawer: DrawerWidget(),
//           appBar: AppToolbar.appBar(
//             title: "Choose Address'",
//             actionIcon: Builder(
//               builder: (context) => IconButton(
//                 icon: Icon(
//                   CupertinoIcons.profile_circled,
//                   color: Color.fromARGB(255, 236, 218, 48),
//                   size: 32,
//                 ),
//                 onPressed: () => Scaffold.of(context).openEndDrawer(),
//                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               ),
//             ),
//           ),
//
//           body: Obx(()=>Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   height: 450,
//                   child: Stack(
//                     children: [
//                       GoogleMap(
//                         compassEnabled: true,
//
//                         myLocationButtonEnabled: true,
//                         minMaxZoomPreference: MinMaxZoomPreference(17, 26),
//                         //  mapType: MapType.satellite,
//                         zoomGesturesEnabled: true,
//                         buildingsEnabled: false,
//
//                         onCameraMove:homePageController.onCamerMove,
//                         initialCameraPosition:CameraPosition(target: LatLng(lat, long)),
//                         onMapCreated:homePageController.onMapCreated,
//                       ),
//                       Align(
//                           alignment: Alignment.center,
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 36.0),
//                             child: Image.asset(
//                               'assets/map_pin.png',
//                               height: 36,
//                             ),
//                           )),
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 400.0, left: 10),
//                           child: ElevatedButton.icon(
//                               style:
//                               ElevatedButton.styleFrom(primary: Colors.white),
//                               onPressed: () {
//                                 homePageController. GetAddressFromLatLong();
//                               },
//                               icon: Icon(
//                                 Icons.my_location,
//                                 color: Colors.green,
//                                 size: 20,
//                               ),
//                               label: Text(
//                                 "Use Your Current Location",
//                                 style:
//                                 TextStyle(color: Colors.green, fontSize: 12),
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(child:Text("${homePageController.searchLocationController.value.text}",maxLines: 1,)),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: Colors.green),
//                     onPressed: () {Get.back();},
//                     child: Text("Done")),
//
//               ],
//             ),
//           ))),
//     );
//   }
// }