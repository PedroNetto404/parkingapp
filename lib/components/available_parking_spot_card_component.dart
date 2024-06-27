import 'package:flutter/material.dart';
import 'package:parkingapp/models/parking_spot_model.dart';

class AvailableParkingSpotCardComponent extends StatelessWidget {
  final ParkingSpotModel spot;
  final void Function() onReserve;

  const AvailableParkingSpotCardComponent(
      {super.key, required this.spot, required this.onReserve});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onReserve,
        child: Card(
            color: spot.canBeReserved
                ? Colors.green
                : spot.occupeid
                    ? Colors.red
                    : spot.reserved
                        ? Colors.yellow
                        : Colors.grey,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vaga ${spot.location}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (spot.canBeReserved)
                      ElevatedButton(
                        onPressed: onReserve,
                        child: const Text('Reservar'),
                      )
                  ],
                ))),
      );
}
