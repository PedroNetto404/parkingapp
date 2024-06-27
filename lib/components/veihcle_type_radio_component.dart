import 'package:flutter/material.dart';

import '../models/veihcle_type.dart';

class VeihcleTypeRadioComponent extends StatefulWidget {
  final void Function(VeihcleType?) onChanged;

  const VeihcleTypeRadioComponent({super.key, required this.onChanged});

  @override
  State<VeihcleTypeRadioComponent> createState() =>
      _VeihcleTypeRadioComponentState();
}

class _VeihcleTypeRadioComponentState extends State<VeihcleTypeRadioComponent> {
  var currentType = VeihcleType.car;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tipo de veículo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _radio(VeihcleType.car),
              const Text('Carro'),
              _radio(VeihcleType.motorcycle),
              const Text('Moto'),
              _radio(VeihcleType.truck),
              const Text('Caminhão'),
            ],
          ),
        ],
      );

  _radio(VeihcleType veihcleType) => Radio(
      value: veihcleType,
      groupValue: currentType,
      onChanged: (value) {
        if (value != null) {
          setState(() => currentType = value);
        }

        widget.onChanged(value);
      });
}
