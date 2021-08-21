import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserSendLocation extends StatefulWidget {
  @override
  _UserSendLocationState createState() => _UserSendLocationState();
}

class _UserSendLocationState extends State<UserSendLocation> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  // Position _currentPosition;
  // String _currentAddress;

  TextEditingController searchLocationTextEditingController =
      TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  // String _startAddress;

  // String _destinationAddress = '';
  // String _placeDistance;

  // _getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(() {
  //       _currentPosition = position;
  //       print('CURRENT POS: $_currentPosition');
  //       mapController.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(position.latitude, position.longitude),
  //             zoom: 18.0,
  //           ),
  //         ),
  //       );
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _getAddress() async {
  //   try {
  //     List<Placemark> p = await placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);

  //     Placemark place = p[0];

  //     setState(() {
  //       _currentAddress = "${place.name}, ${place.locality}, ${place.country}";
  //       searchLocationTextEditingController.text = _currentAddress;
  //       _startAddress = _currentAddress;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget _textField({
    TextEditingController controller,
    FocusNode focusNode,
    String label,
    String hint,
    double width,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      height: 50.0,
      width: width * 0.9,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white60,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    print(position);
    print(position.latitude);
    print(position.longitude);

    return position;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff63676a),
        child: Container(
          height: height * .85,
          decoration: BoxDecoration(
              color: AppColors.greenBlue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(BaseStyles.borderRadius),
                  topRight: Radius.circular(BaseStyles.borderRadius))),
          child: Column(
            children: [
              Text(
                "Select Location",
                style: TextStyles.buttonTextLight,
                textScaleFactor: 1.3,
              ),
              SizedBox(
                height: height * .01,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: height * .7,
                      child: GoogleMap(
                        // markers:
                        // markers != null ? Set<Marker>.from(markers) : null,
                        initialCameraPosition: _initialLocation,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        // polylines: Set<Polyline>.of(polylines.values),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _textField(
                            hint: 'Search ...',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: () {
                                getCurrentLocation();
                                // searchLocationTextEditingController.text =
                                //     _currentAddress;
                                // _startAddress = _currentAddress;
                              },
                            ),
                            controller: searchLocationTextEditingController,
                            focusNode: startAddressFocusNode,
                            width: width,
                            locationCallback: (String value) {
                              setState(() {
                                // _startAddress = value;
                              });
                            }),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 20.0, vertical: 10.0),
                        //   child: TextField(
                        //     style: TextStyles.buttonTextDarkSmall,
                        //     controller: searchLocationTextEditingController,
                        //     decoration: InputDecoration(
                        //         hintText: "Search ...",
                        //         border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(
                        //                 BaseStyles.borderRadius)),
                        //         suffixIcon: GestureDetector(
                        //             onTap: () {
                        //               getCurrentLocation();
                        //             },
                        //             child: Icon(Icons.my_location))),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppButton(
                  buttonText: "Send Location",
                  buttonType: ButtonType.brownblack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
