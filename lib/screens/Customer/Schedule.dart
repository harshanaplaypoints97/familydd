// // ignore: file_names

// import 'package:familydriver/provider/LocationProvider.dart';
// import 'package:familydriver/provider/map_provider.dart';

// import 'package:familydriver/screens/widgets/TextComponent.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import 'RideConfirmPage_a.dart';

// class ScheduleRide extends StatefulWidget {
//   const ScheduleRide({super.key});

//   @override
//   _ScheduleRideState createState() => _ScheduleRideState();
// }

// class _ScheduleRideState extends State<ScheduleRide> {
//   bool mapcamera = false;
//   bool searchedaddressed = false;
//   String address1 = '';
//   String address2 = '';
//   String city = '';

//   double latitude = 0.0;
//   double logitude = 0.0;

//   String googleApikey = "AIzaSyCUxEMFFSkmyz5j9_Cjy2_VUUyUP4-h1CM";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   LatLng startLocation = LatLng(7.8731, 80.7718);
//   String location1 =
//       "Search Pickup Location                                                          ";
//   String location2 =
//       "Search Drop Location                                                         ";
//   Position? currentPosition; // Add this line

//   @override
//   void initState() {
//     super.initState();
//     // Get the user's current location continuously
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<Mapprovider, LocationProvider>(
//       builder: (context, value, value2, child) => Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     markers: {
//                       Marker(
//                         infoWindow: const InfoWindow(
//                             title: "My Pickup Position", snippet: ""),
//                         markerId: const MarkerId("1"),
//                         position: LatLng(
//                           value2.startlatitude,
//                           value2.stratlongitude,
//                         ),
//                       ),
//                       Marker(
//                         infoWindow: const InfoWindow(
//                             title: "My Drop Position", snippet: ""),
//                         markerId: const MarkerId("2"),
//                         position: LatLng(
//                           value2.endlatitude,
//                           value2.endlongitude,
//                         ),
//                       ),
//                     },
//                     polylines: {
//                       Polyline(
//                           polylineId: PolylineId("1"),
//                           color: Colors.green,
//                           width: 5,
//                           points: value2.polyData)
//                     },
//                     initialCameraPosition: CameraPosition(
//                       //innital position in map
//                       target: searchedaddressed
//                           ? LatLng(cameraPosition!.target.latitude,
//                               cameraPosition!.target.longitude)
//                           : LatLng(
//                               value2.position!.latitude,
//                               value2.position!.longitude,
//                             ), //initial position
//                       zoom: 14.0, //initial zoom level
//                     ),

//                     mapType: MapType.normal, //map type
//                     onMapCreated: (controller) {
//                       //method called when map is created
//                       setState(() {
//                         mapController = controller;
//                       });
//                     },
//                     onCameraMove: (CameraPosition cameraPositiona) {
//                       cameraPosition = cameraPositiona;
//                     },
//                     onCameraIdle: () async {
//                       List<Placemark> placemarks =
//                           await placemarkFromCoordinates(
//                         value2.position!.latitude,
//                         value2.position!.longitude,
//                       );

//                       placemarkFromCoordinates(cameraPosition!.target.latitude,
//                           cameraPosition!.target.longitude);
//                       setState(() {
//                         // ignore: prefer_interpolation_to_compose_strings
//                         location1 = placemarks.first.administrativeArea
//                                 .toString() +
//                             ", " +
//                             placemarks.first.street.toString() +
//                             "," +
//                             placemarks.first.subAdministrativeArea.toString() +
//                             "" +
//                             placemarks.first.country.toString();

//                         city = placemarks.first.administrativeArea.toString();
//                         address1 = placemarks.first.street.toString();
//                         address2 =
//                             placemarks.first.subAdministrativeArea.toString();
//                         latitude = cameraPosition!.target.latitude;
//                         logitude = cameraPosition!.target.longitude;
//                       });
//                     },
//                   ),

//                   //search autoconplete input
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(100))),
//                 child: Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Container(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           InkWell(
//                             onTap: () async {
//                               var place = await PlacesAutocomplete.show(
//                                   context: context,
//                                   apiKey: googleApikey,
//                                   mode: Mode.overlay,
//                                   types: [],
//                                   strictbounds: false,
//                                   //google_map_webservice package
//                                   onError: (err) {
//                                     print(err);
//                                   });

//                               if (place != null) {
//                                 setState(() {
//                                   location1 = place.description.toString();
//                                 });
//                                 //form google_maps_webservice package
//                                 final plist = GoogleMapsPlaces(
//                                   apiKey:
//                                       "AIzaSyCUxEMFFSkmyz5j9_Cjy2_VUUyUP4-h1CM",
//                                   apiHeaders:
//                                       await GoogleApiHeaders().getHeaders(),
//                                   //from google_api_headers package
//                                 );
//                                 String placeid = place.placeId ?? "0";
//                                 final detail =
//                                     await plist.getDetailsByPlaceId(placeid);
//                                 final geometry = detail.result.geometry!;
//                                 final lat = geometry.location.lat;
//                                 final lang = geometry.location.lng;
//                                 value2.StartPositions(geometry.location.lat,
//                                     geometry.location.lng);

//                                 value2.getployline();

//                                 var newlatlang = LatLng(lat, lang);

//                                 //move map camera to selected place with animation
//                                 mapController?.animateCamera(
//                                     CameraUpdate.newCameraPosition(
//                                         CameraPosition(
//                                             target: newlatlang, zoom: 17)));
//                               }
//                             },
//                             child: Container(
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     TextComponent(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.w700,
//                                         fontsize: 20,
//                                         text: "Pick up  "),
//                                     Container(
//                                         padding: EdgeInsets.all(0),
//                                         child: Text(
//                                           location1,
//                                           style: TextStyle(fontSize: 18),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               value2.clearendPositions();
//                               var place = await PlacesAutocomplete.show(
//                                   context: context,
//                                   apiKey: googleApikey,
//                                   mode: Mode.overlay,
//                                   types: [],
//                                   strictbounds: false,
//                                   //google_map_webservice package
//                                   onError: (err) {
//                                     print(err);
//                                   });

//                               if (place != null) {
//                                 setState(() {
//                                   location2 = place.description.toString();
//                                 });
//                                 //form google_maps_webservice package
//                                 final plist = GoogleMapsPlaces(
//                                   apiKey:
//                                       "AIzaSyCUxEMFFSkmyz5j9_Cjy2_VUUyUP4-h1CM",
//                                   apiHeaders:
//                                       await GoogleApiHeaders().getHeaders(),
//                                   //from google_api_headers package
//                                 );
//                                 String placeid = place.placeId ?? "0";
//                                 final detail =
//                                     await plist.getDetailsByPlaceId(placeid);
//                                 final geometry = detail.result.geometry!;
//                                 final lat = geometry.location.lat;
//                                 final lang = geometry.location.lng;
//                                 value2.endPositions(geometry.location.lat,
//                                     geometry.location.lng);

//                                 value2.getployline();

//                                 var newlatlang = LatLng(lat, lang);

//                                 //move map camera to selected place with animation
//                                 mapController?.animateCamera(
//                                     CameraUpdate.newCameraPosition(
//                                         CameraPosition(
//                                             target: newlatlang, zoom: 17)));
//                               }
//                             },
//                             child: Container(
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     TextComponent(
//                                         color: const Color(0xffFF7F50),
//                                         fontWeight: FontWeight.w700,
//                                         fontsize: 20,
//                                         text: "Drop      "),
//                                     Container(
//                                         padding: EdgeInsets.all(0),
//                                         child: Text(
//                                           location2,
//                                           style: TextStyle(fontSize: 18),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => Ridedetail(
//                                                 Distance: value2.distance
//                                                     .toStringAsFixed(2),
//                                                 totalprice:
//                                                     value2.distance * 180,
//                                               )));
//                                 },
//                                 child: Container(
//                                   child: Center(
//                                     child: TextComponent(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                         fontsize: 20,
//                                         text: "Next"),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   height: 50,
//                                   width:
//                                       MediaQuery.of(context).size.width / 2.45,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
