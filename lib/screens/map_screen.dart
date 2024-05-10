// import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});
//
//   static const String id = 'MapScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Container(),
//         centerTitle: true,
//         title: Text('Map',style: TextStyle(color: Colors.black,fontSize: 20),),
//         actions: [
//           TextButton(onPressed:() => Navigator.pop(context), child: Text('Next >',style: TextStyle(color: Colors.blue ,fontSize: 20),),)
//         ],
//       ),
//       body: BlocBuilder<MapCubit, MapState>(builder: (context, state) {
//         if (state is GetLocationSuccess) {
//           return FlutterMap(
//             options: MapOptions(
//               initialCenter:
//                   LatLng(state.position.latitude, state.position.longitude),
//               initialZoom: 19,
//               onTap: (TapPosition position, LatLng latLng) {
//                 latLng = latLng;
//                 print('Latitude: ${latLng.latitude}');
//                 print('Longitude: ${latLng.longitude}');
//               },
//             ),
//             children: [
//               MarkerLayer(markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: LatLng(
//                       state.position.latitude, state.position.longitude),
//                   child: Icon(
//                     Icons.location_on,
//                     size: 45.0,
//                     color: Colors.red,
//                   ),
//                 ),
//               ]),
//               TileLayer(
//                 // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 urlTemplate:
//                     "https://www.google.com/maps/vt?lyrs=m@189&gl=cn&x={x}&y={y}&z={z}",
//                 userAgentPackageName: 'com.example.app',
//                 // maxZoom: 10,
//               ),
//             ],
//           );
//         }
//         return Center(child: CircularProgressIndicator());
//       }),
//     );
//   }
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:latlong2/latlong.dart';
// //
// // class CenterFabExample extends StatefulWidget {
// //   @override
// //   _CenterFabExampleState createState() => _CenterFabExampleState();
// // }
// //
// // class _CenterFabExampleState extends State<CenterFabExample> {
// //   late AlignOnUpdate _alignPositionOnUpdate;
// //   late final StreamController<double?> _alignPositionStreamController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _alignPositionOnUpdate = AlignOnUpdate.always;
// //     _alignPositionStreamController = StreamController<double?>();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _alignPositionStreamController.close();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Map'),
// //       ),
// //       body: FlutterMap(
// //         options: MapOptions(
// //           initialCenter: const LatLng(30.033333, 31.233334),
// //           initialZoom: 9.2,
// //           minZoom: 0,
// //           maxZoom: 19,
// //           onTap: _retPositionMap,
// //           // onTap: (TapPosition, LatLng) {
// //           //   // Align the location marker to the center of the map widget
// //           //   // on location update until user interact with the map.
// //           //   setState(
// //           //     () => _alignPositionOnUpdate = AlignOnUpdate.always,
// //           //   );
// //           //   // Align the location marker to the center of the map widget
// //           //   // and zoom the map to level 18.
// //           //   _alignPositionStreamController.add(18);
// //           // },
// //           // Stop aligning the location marker to the center of the map widget
// //           // if user interacted with the map.
// //           onPositionChanged: (MapPosition position, bool hasGesture) {
// //             if (hasGesture && _alignPositionOnUpdate != AlignOnUpdate.never) {
// //               setState(
// //                 () => _alignPositionOnUpdate = AlignOnUpdate.never,
// //               );
// //             }
// //           },
// //         ),
// //         // ignore: sort_child_properties_last
// //         children: [
// //           TileLayer(
// //             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
// //             userAgentPackageName:
// //                 'net.tlserver6y.flutter_map_location_marker.example',
// //             maxZoom: 19,
// //           ),
// //           CurrentLocationLayer(
// //             alignPositionStream: _alignPositionStreamController.stream,
// //             alignPositionOnUpdate: _alignPositionOnUpdate,
// //           ),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: Padding(
// //               padding: const EdgeInsets.all(20.0),
// //               child: FloatingActionButton(
// //                 backgroundColor: Colors.blue,
// //                 onPressed: () {
// //                   // Align the location marker to the center of the map widget
// //                   // on location update until user interact with the map.
// //                   setState(
// //                     () => _alignPositionOnUpdate = AlignOnUpdate.always,
// //                   );
// //                   // Align the location marker to the center of the map widget
// //                   // and zoom the map to level 18.
// //                   _alignPositionStreamController.add(18);
// //                 },
// //                 child: const Icon(
// //                   Icons.my_location,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // void _retPositionMap(dynamic position, LatLng direct) {
// //
// //   print(position.runtimeType);
// //   print(direct.latitude);
// //   print(direct.longitude);
// }
