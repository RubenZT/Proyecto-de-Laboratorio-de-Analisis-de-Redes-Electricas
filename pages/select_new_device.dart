import 'package:plug/models/device.dart';
import 'package:plug/widgets/select_new_device/new_device.dart';
import 'package:plug/widgets/shared/app_icon.dart';
import 'package:plug/widgets/shared/bottom_bar.dart';
import 'package:flutter/material.dart';

class SelectNewDevice extends StatelessWidget {
  const SelectNewDevice({Key? key}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AppICon(),
                Text(
                  'Agrega un Equipo Nuevo:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var type in Device.types.keys) NewDevice(type: type),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 1,
      ),
    );
  }
}
