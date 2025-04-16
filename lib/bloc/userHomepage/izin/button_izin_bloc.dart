import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/absenService.dart';
import 'package:absenku/service/geo_service.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'button_izin_event.dart';
part 'button_izin_state.dart';

class ButtonIzinBloc extends Bloc<ButtonIzinEvent, ButtonIzinState> {
  ButtonIzinBloc() : super(ButtonIzinInitial()) {
    on<ButtonIzinEvent>((event, emit) async {
      if (event is CommitData) {
        emit(ButtonIzinLoading());
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
        absenModel data = await Absenservice().izin(
          lat: currentLat,
          long: currentLong,
          addres: currentAddress,
          aslasan: event.alasanIzin,
        );
        emit(ButtonIzinSuccses(absenData: data));
      }
    });
  }
}
