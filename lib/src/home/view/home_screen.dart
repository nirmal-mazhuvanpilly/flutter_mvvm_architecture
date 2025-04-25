import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteConstants.routeCounterScreen);
                  },
                  child: const Text("Counter")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteConstants.routePassengerScreen);
                  },
                  child: const Text("Passenger")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteConstants.routeFeedScreen);
                  },
                  child: const Text("Study Material")),
            ],
          ),
        ),
      ),
    );
  }
}
