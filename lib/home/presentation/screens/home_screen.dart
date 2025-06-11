import 'package:esp32/home/presentation/controllers/cubits/Internet_connection_cubit/internet_connection_cubit.dart';
import 'package:esp32/home/presentation/controllers/cubits/Internet_connection_cubit/internet_connection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
              builder: (context, state) {
                if (state is InternetConnectionSuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Internet Connection successful"),
                      Icon(Icons.check_circle_outlined),
                    ],
                  );
                } else if (state is InternetConnectionFailure) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Internet Connection Failed"),
                      Icon(Icons.cancel_outlined),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<InternetConnectionCubit>(
                  context,
                ).checkConnectionStatus();
              },
              child: Text("test connection"),
            ),
          ],
        ),
      ),
    );
  }
}
