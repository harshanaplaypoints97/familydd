// ignore: file_names

import 'package:familydriver/Api/Customer_Loacation_End_points.dart';
import 'package:familydriver/provider/LocationProvider.dart';
import 'package:familydriver/provider/map_provider.dart';
import 'package:familydriver/screens/Customer/Drvers_List_Page.dart';
import 'package:familydriver/screens/Customer/Near_Drver_List_page.dart';

import 'package:familydriver/screens/widgets/TextComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddFaverioteLocation extends StatefulWidget {
  String token, Location;
  int id;

  AddFaverioteLocation({
    super.key,
    required this.token,
    required this.id,
    required this.Location,
  });

  @override
  _AddFaverioteLocationState createState() => _AddFaverioteLocationState();
}

class _AddFaverioteLocationState extends State<AddFaverioteLocation> {
  var num = 0;
  late LocationProvider _locationprovider;
  late CustomerAddLocation _customerlocation;
  bool mapcamera = false;
  bool searchedaddressed = false;
  String address1 = '';
  String address2 = '';
  String city = '';

  double latitude = 0.0;
  double logitude = 0.0;

  String googleApikey = "AIzaSyCUxEMFFSkmyz5j9_Cjy2_VUUyUP4-h1CM";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(7.8731, 80.7718);
  String location1 = "Search Pickup Location";
  String location2 = "Search Drop Location";
  Position? currentPosition; // Add this line

  @override
  void initState() {
    _locationprovider = Provider.of<LocationProvider>(context, listen: false);
    _locationprovider.clearPolyline();
    _locationprovider.clearendPositions();
    _customerlocation =
        Provider.of<CustomerAddLocation>(context, listen: false);

    super.initState();
    // Get the user's current location continuously
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Mapprovider, LocationProvider>(
      builder: (context, value, value2, child) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  GoogleMap(
                    markers: {
                      Marker(
                        infoWindow: const InfoWindow(
                            title: "My Pickup Position", snippet: ""),
                        markerId: const MarkerId("1"),
                        position: LatLng(
                          value2.startlatitude,
                          value2.stratlongitude,
                        ),
                      ),
                      Marker(
                        infoWindow: const InfoWindow(
                            title: "My Drop Position", snippet: ""),
                        markerId: const MarkerId("2"),
                        position: LatLng(
                          value2.endlatitude,
                          value2.endlongitude,
                        ),
                      ),
                    },
                    polylines: {
                      Polyline(
                          polylineId: PolylineId("1"),
                          color: Colors.green,
                          width: 5,
                          points: value2.polyData)
                    },
                    initialCameraPosition: CameraPosition(
                      //innital position in map
                      target: searchedaddressed
                          ? LatLng(cameraPosition!.target.latitude,
                              cameraPosition!.target.longitude)
                          : LatLng(
                              value2.position!.latitude,
                              value2.position!.longitude,
                            ), //initial position
                      zoom: 14.0, //initial zoom level
                    ),

                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) {
                      //method called when map is created
                      setState(() {
                        mapController = controller;
                      });
                    },
                    onCameraMove: (CameraPosition cameraPositiona) {
                      cameraPosition = cameraPositiona;
                    },
                    onCameraIdle: () async {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        value2.position!.latitude,
                        value2.position!.longitude,
                      );

                      placemarkFromCoordinates(cameraPosition!.target.latitude,
                          cameraPosition!.target.longitude);
                      setState(() {
                        // ignore: prefer_interpolation_to_compose_strings
                        location1 = placemarks.first.administrativeArea
                                .toString() +
                            ", " +
                            placemarks.first.street.toString() +
                            "," +
                            placemarks.first.subAdministrativeArea.toString() +
                            "" +
                            placemarks.first.country.toString();

                        city = placemarks.first.administrativeArea.toString();
                        address1 = placemarks.first.street.toString();
                        address2 =
                            placemarks.first.subAdministrativeArea.toString();
                        latitude = cameraPosition!.target.latitude;
                        logitude = cameraPosition!.target.longitude;
                      });
                    },
                  ),

                  //search autoconplete input
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (num >= 1) {
                              _locationprovider.clearPolyline();
                            }

                            value2.clearendPositions();
                            var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: googleApikey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                components: [
                                  Component(Component.country, 'Lk')
                                ],
                                //google_map_webservice package
                                onError: (err) {
                                  print(err);
                                });

                            if (place != null) {
                              setState(() {
                                location2 = place.description.toString();
                              });
                              //form google_maps_webservice package
                              final plist = GoogleMapsPlaces(
                                apiKey:
                                    "AIzaSyCUxEMFFSkmyz5j9_Cjy2_VUUyUP4-h1CM",
                                apiHeaders:
                                    await GoogleApiHeaders().getHeaders(),
                                //from google_api_headers package
                              );
                              String placeid = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;

                              value2.endPositions(
                                  geometry.location.lat, geometry.location.lng);

                              value2.getployline();

                              var newlatlang = LatLng(lat, lang);
                              setState(() {
                                latitude = lat;
                                logitude = lang;
                              });

                              //move map camera to selected place with animation
                              mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: newlatlang, zoom: 17)));
                            }
                            num++;
                          },
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.favorite),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      TextComponent(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontsize: 20,
                                          text: "Add Favorite Location"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      height: 50,
                                      color: const Color.fromARGB(
                                          255, 218, 217, 217),
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.search),
                                          Center(
                                            child: Text(
                                              ' ' + location1,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _customerlocation.addlocation(
                                    widget.token,
                                    widget.id,
                                    location2,
                                    latitude,
                                    logitude,
                                    widget.Location,
                                    context);
                              },
                              child: Container(
                                child: Center(
                                  child: TextComponent(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontsize: 15,
                                      text: "Add Your " +
                                          widget.Location +
                                          " Location"),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
