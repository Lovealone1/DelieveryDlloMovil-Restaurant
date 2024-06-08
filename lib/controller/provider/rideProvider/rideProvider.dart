import 'package:covefood_domiciliario/controller/services/directionServices/directionServices.dart';
import 'package:covefood_domiciliario/model/directionModel.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:covefood_domiciliario/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideProvider extends ChangeNotifier {
  Position? currentPosition;
  LatLng? delieveryGuyLocation;
  LatLng? restaurantLocation;
  LatLng? delieveryLocation;
  FoodOrderModel? orderData;
  Set<Polyline> polylineSetTowardsRestaurant = {};
  Polyline? polylineTowardsRestaurant;
  List<LatLng> polylineCoordinatesListTowardsRestaurant = [];

  Set<Polyline> polylinesSetTowardsDelievery = {};
  Polyline? polylinesTowardsDelievery;
  List<LatLng> polylineCoordinatesListTowardsDelievery = [];

  updateCurrentPosition(Position crrPosition) {
    currentPosition = crrPosition;
    notifyListeners();
  }

  updateDelieveryLatLngs(
      LatLng delieveryGuy, LatLng restaurant, LatLng delievery) {
    delieveryGuyLocation = delieveryGuy;
    restaurantLocation = delieveryGuy;
    delieveryLocation = delievery;
    notifyListeners();
  }
  updateOrderData(FoodOrderModel data) {
      orderData = data;
      notifyListeners();
    }
  decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> data = polylinePoints.decodePolyline(encodedPolyline);
    List<LatLng> polylineCoordinatesList = [];
    if (data.isNotEmpty) {
      for (var latLngPoints in data) {
        polylineCoordinatesList.add(
          LatLng(
            latLngPoints.latitude,
            latLngPoints.longitude,
          ),
        );
      }
    }
    Polyline polyline = Polyline(
      polylineId: const PolylineId('polilyne'),
      color: black,
      points: polylineCoordinatesList,
      jointType: JointType.round,
      width: 3,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );
    return polyline;
  }

  fetchCurrentLocationToRestaurantPolyline(BuildContext context) async {
    polylineSetTowardsRestaurant.clear();
    DirectionModel directionModel = await DirectionServices.getDirectionDetails(
      delieveryGuyLocation!,
      restaurantLocation!,
      context,
    );
    Polyline polyline = decodePolyline(directionModel.polylinePoints);
    polylineSetTowardsRestaurant.add(polyline);
    notifyListeners();
  }

  fetchRestaurantLocationToDelieveryPolyline(BuildContext context) async {
    polylinesSetTowardsDelievery.clear();
    DirectionModel directionModel = await DirectionServices.getDirectionDetails(
      restaurantLocation!,
      delieveryGuyLocation!,
      context,
    );
    Polyline polyline = decodePolyline(directionModel.polylinePoints);
    polylinesSetTowardsDelievery.add(polyline);
    notifyListeners();
  }
}
