import 'dart:async';

import 'package:app_cooky/providers/deliver_provider.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class CostomGoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CostomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  // final Location _location = Location();
  Geolocator geolocatort = Geolocator();

  late Position currentPosition;
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    return position;
  }

// void animateCameraToNewPosition(CameraPosition cameraPosition) {
//   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
// }

// void listenToLocationChanges() {
//   Geolocator.getPositionStream(
//           desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
//       .listen((position) {
//     if (currentPosition != null &&
//         (currentPosition.latitude != position.latitude ||
//             currentPosition.longitude != position.longitude)) {
//       currentPosition = position;
//       animateCameraToNewPosition(CameraPosition(
//         target: LatLng(currentPosition.latitude, currentPosition.longitude),
//         zoom: 15,
//       ));
//     }
//   });
// }

  // void _onMapCreated(GoogleMapController _value) {
  //   controller = _value;

  //   _location.onLocationChanged.listen((event) {
  //     controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target: LatLng(event.latitude, event.longitude), zoom: 15),
  //       ),
  //     );
  //   });
  // }
  late LatLng _initialPosition;
  late StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _listenToLocationChanges();
  }

  @override
  void dispose() {
    if (_positionStream != null) {
      _positionStream.cancel();
    }
    super.dispose();
  }

  void _listenToLocationChanges() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _animateCameraToCurrentPosition(position.latitude, position.longitude);
    });
  }

  void _animateCameraToCurrentPosition(double latitude, double longitude) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    getCurrentLocation();

    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       child: Stack(
    //         children: [
    //           GoogleMap(
    //               initialCameraPosition: CameraPosition(
    //                 target: _initialcameraposition,
    //               ),
    //               mapType: MapType.normal,
    //               onMapCreated: (GoogleMapController controller) {
    //                 _controller = controller;
    //               }),
    //           Positioned(
    //             bottom: 0,
    //             left: 0,
    //             right: 0,
    //             child: Container(
    //               height: 50,
    //               width: double.infinity,
    //               margin:
    //                   EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
    //               child: MaterialButton(
    //                 onPressed: () async {
    //                   await Geolocator.getCurrentPosition().then((value) {
    //                     setState(() {
    //                       checkoutProvider.setvitri = value;
    //                     });
    //                   });
    //                   Navigator.of(context).pop();
    //                 },
    //                 color: primaryColor,
    //                 // child: Text("Set Location"),
    //                 child: Text("Xác định vị trí"),
    //                 shape: StadiumBorder(),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialcameraposition,
                  ),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    controller = _controller;
                  }),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      LocationPermission permission =
                          await Geolocator.checkPermission();
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                      }
                      if (permission == LocationPermission.whileInUse ||
                          permission == LocationPermission.always) {
                        _listenToLocationChanges;
                        await Geolocator.getCurrentPosition().then((value) {
                          setState(() {
                            checkoutProvider.setvitri = value;
                          });
                        });
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(msg: "Vui lòng cấp quyền");
                      }
                    },
                    color: primaryColor,
                    child: Text("Nhập vị trí hiện tại"),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
