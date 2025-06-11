import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:esp32/home/presentation/controllers/cubits/Internet_connection_cubit/internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  void checkConnectionStatus() async {
    final status = await InternetConnections().checkConnectionStatus();
    if (status == ConnectionType.none) {
      emit(InternetConnectionFailure());
    } else {
      emit(InternetConnectionSuccess());
    }
  }
}

enum ConnectionType { mobile, wifi, none }

class InternetConnections {
  Future<ConnectionType> checkConnectionStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return ConnectionType.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return ConnectionType.wifi;
    } else {
      return ConnectionType.none;
    }
  }
}
