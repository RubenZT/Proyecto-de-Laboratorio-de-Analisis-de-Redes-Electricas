import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plug/models/device.dart';
import 'package:plug/pages/home.dart';

class AddedDevice extends StatefulWidget {
  final Device device;
  final double totalConsumption;
  const AddedDevice({Key? key, required this.device, required this.totalConsumption}) : super(key: key);

  @override
  State<AddedDevice> createState() => _AddedDeviceState();
}

class _AddedDeviceState extends State<AddedDevice> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        final box = GetStorage();
        final devices = box.read<List>('devices') ?? [];

        devices.removeAt(widget.device.idx!);
        box.write('devices', devices);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Home()));
      },
      borderRadius: BorderRadius.circular(4),
      child: Card(
        color: const Color.fromARGB(255, 205, 239, 255),
        child: SizedBox.square(
          dimension: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(widget.device.getIconData(), size: 24),
                          ),
                        ),
                        Switch(
                          value: widget.device.active,
                          onChanged: (value) {
                            final box = GetStorage();
                            final devices = box.read<List>('devices') ?? [];

                            devices[widget.device.idx!]['active'] = value;

                            box.write('devices', devices);

                            setState(() {
                              widget.device.active = value;
                            });
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Row(
                        children: [
                          Text(
                            widget.device.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FAProgressBar(
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  size: 16,
                  currentValue: (100 * widget.device.power * widget.device.useTime * widget.device.quantity) / widget.totalConsumption,
                  displayText: '%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
