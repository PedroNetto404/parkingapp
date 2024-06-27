import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingapp/components/available_parking_spot_card_component.dart';
import 'package:parkingapp/models/parking_spot_model.dart';
import 'package:parkingapp/models/veihcle_model.dart';
import '../../controllers/parking_controller.dart';
import '../../routes/app_routes.dart';

class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<StatefulWidget> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  int _selectedIndex = 0;

  final _parkingController = Get.find<ParkingController>();

  static final _navigationItems = [
    {
      'icon': const Icon(Icons.local_parking),
      'label': 'Vagas Disponíveis',
      'tooltip': 'Reserve uma vaga de estacionamento',
    },
    {
      'icon': const Icon(Icons.person),
      'label': 'Perfil',
      'tooltip': 'Veja e edite suas informações de perfil',
    },
    {
      'icon': const Icon(Icons.bookmark),
      'label': 'Reservas',
      'tooltip': 'Veja suas reservas de estacionamento',
    },
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              const Text('Parking App', style: TextStyle(color: Colors.white)),
          //logout button
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Get.offAllNamed(AppRoutes.signIn),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationItems
              .map(
                (item) => BottomNavigationBarItem(
                    icon: item['icon'] as Icon,
                    label: item['label'] as String,
                    tooltip: item['tooltip'] as String),
              )
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (int index) => setState(() => _selectedIndex = index),
        ),
        body: StreamBuilder(
            stream: _parkingController.parkingSpotRepository.realTimeSpots,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar vagas'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<ParkingSpotModel> spots = (snapshot.data?.docs ?? [])
                  .map((e) => ParkingSpotModel.fromJson(e.data()))
                  .toList();

              if (spots.isEmpty) {
                return const Align(
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.sentiment_dissatisfied),
                          SizedBox(width: 8),
                          Text('Nenhuma vaga disponível')
                        ]));
              }

              return GridView.builder(
                  itemCount: spots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final spot = spots[index];

                    return AvailableParkingSpotCardComponent(
                        spot: spot,
                        onReserve: () =>
                            _showSelectVehicleDialog(context, spot));
                  });
            }),
      );

  void _showSelectVehicleDialog(BuildContext context, ParkingSpotModel spot) {
    _parkingController.customerRepository.current
        .then((customer) => customer.veihcles)
        .then((vehicles) {
      showDialog(
          context: context,
          builder: (context) => _SelectVeihcleDialog(
                vehicles: vehicles,
                onSelect: (vehicleId) {
                  _parkingController.reserveSpot(
                      spot: spot,
                      vehicleId: vehicleId.id,
                      expectedCheckIn: DateTime.now());
                },
              ));
    });
  }
}

class _SelectVeihcleDialog extends StatelessWidget {
  final List<VeihcleModel> vehicles;
  final void Function(VeihcleModel) onSelect;

  const _SelectVeihcleDialog({required this.vehicles, required this.onSelect});

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: const Text('Selecione um veículo'),
        children: vehicles
            .map((vehicle) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, vehicle);
                    onSelect(vehicle);
                  },
                  child: Text(vehicle.name),
                ))
            .toList(),
      );
}
