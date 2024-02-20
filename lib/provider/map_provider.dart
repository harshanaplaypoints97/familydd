import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapprovider extends ChangeNotifier {
  //Goggle Map Controller
  final Completer<GoogleMapController> _controller = Completer();

  //map created

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    notifyListeners();
  }
}
