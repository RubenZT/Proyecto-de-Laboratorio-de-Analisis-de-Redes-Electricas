import 'package:dotted_border/dotted_border.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plug/models/device.dart';
import 'package:plug/pages/select_new_device.dart';
import 'package:plug/widgets/shared/app_icon.dart';
import 'package:plug/widgets/home/added_device.dart';
import 'package:plug/widgets/shared/bottom_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final devices = (GetStorage().read<List>('devices') ?? []).map((e) => Device.fromJson(e));
  double total = 0;

  @override
  void initState() {
    super.initState();
    for (var device in devices) {
      total += device.power * device.quantity * device.useTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFedf1f5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 16,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: AppICon()),
          const Text(
            'PLUG',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const Text(
            'Interfaz de monitoreo de consumo Eléctrico Residencial',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...devices.map(
                    (e) => AddedDevice(device: e, totalConsumption: total),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const SelectNewDevice()))
                          .then((_) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Home())));
                    },
                    child: Card(
                      color: Colors.white.withOpacity(0.8),
                      child: DottedBorder(
                        strokeWidth: 1.5,
                        color: Colors.black54,
                        dashPattern: const [8],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: const SizedBox.square(
                          dimension: 150,
                          child: Icon(
                            Icons.add_box,
                            size: 40,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }
}
