import 'package:absenku/service/geo_service.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'absen_page_event.dart';
part 'absen_page_state.dart';

class AbsenPageBloc extends Bloc<AbsenPageEvent, AbsenPageState> {
  AbsenPageBloc() : super(AbsenPageInitial()) {
    on<AbsenPageEvent>((event, emit) async {
      if (event is GetData) {
        emit(AbsenPageLoading());
        String currentAddress = "Unknown";
        String currentLatLong = "Unknown";
        double currentLat = 0;
        double currentLong = 0;
        LatLng position = await determineUserLocation();
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}, ${place.country}, ${place.isoCountryCode}";
          currentLatLong = "${position.latitude}, ${position.longitude}";
          currentLat = position.latitude;
          currentLong = position.longitude;
        }
        emit(
          AbsenPageSucsess(
            currentAddress: currentAddress,
            currentLatLong: currentLatLong,
            currentLat: currentLat,
            currentLong: currentLong,
          ),
        );
      }
    });
  }
}
