import 'package:get_storage/get_storage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:plug/models/device.dart';
import 'package:plug/widgets/shared/app_icon.dart';
import 'package:plug/widgets/shared/bottom_bar.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final devices = (GetStorage().read<List>('devices') ?? []).map((e) => Device.fromJson(e));

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
                  'Reparto de Consumo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (devices.any((element) => element.active))
                      PieChart(
                        dataMap: {
                          for (var d in devices)
                            if (d.active) ...{d.name: d.useTime * d.power * d.quantity},
                        },
                      )
                    else
                      const Text(
                        'No hay información que mostrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(height: 16),
                    const Text(
                      'Integrantes:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Angel Zumba',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Anthony Beltran',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Jeffry Beltran',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Erick Vega',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 2,
      ),
    );
  }
}
