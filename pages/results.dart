import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plug/models/device.dart';
import 'package:plug/widgets/shared/app_icon.dart';
import 'package:plug/widgets/shared/bottom_bar.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  double total = 0;
  String date = '';

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    date = [day, month, year].join('-');

    final devices = (GetStorage().read<List>('devices') ?? []).map((e) => Device.fromJson(e));
    for (var device in devices) {
      if (device.active) total += device.power * device.quantity * device.useTime;
    }
  }

  double getPrice(double monthly) {
    double tarifa = 0;
    if (monthly > 35000) {
      tarifa = 0.6812;
    } else if (monthly > 2500) {
      tarifa = 0.4360;
    } else if (monthly > 1500) {
      tarifa = 0.2752;
    } else if (monthly > 1000) {
      tarifa = 0.1719;
    } else if (monthly > 701) {
      tarifa = 0.1450;
    } else if (monthly > 501) {
      tarifa = 0.1285;
    } else if (monthly > 350) {
      tarifa = 0.105;
    } else if (monthly > 300) {
      tarifa = 0.103;
    } else if (monthly > 250) {
      tarifa = 0.101;
    } else if (monthly > 200) {
      tarifa = 0.099;
    } else if (monthly > 150) {
      tarifa = 0.097;
    } else if (monthly > 100) {
      tarifa = 0.083;
    } else if (monthly > 51) {
      tarifa = 0.081;
    } else {
      tarifa = 0.078;
    }

    if (monthly > 130) {
      monthly *= 1.05;
    } else {
      monthly *= 0.95;
    }

    double extra = 0;
    if (monthly > 1000) {
      extra += 7.066;
    } else if (monthly > 500) {
      extra += 4.240;
    } else if (monthly > 300) {
      extra += 2.826;
    } else {
      extra += 1.414;
    }

    return (monthly * tarifa) + extra;
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AppICon(),
                Text(
                  'Datos de Consumo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 205, 239, 255),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Energía Consumida',
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 1),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 233, 248, 255),
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Diario',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                      Text(
                                        'Mensual',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${total.toStringAsFixed(2)} KwH',
                                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                          ),
                                          const Icon(MdiIcons.powerPlug),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(MdiIcons.lightningBolt),
                                          Text(
                                            '${(total * 30).toStringAsFixed(2)} KwH',
                                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Nivel de Consumo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: SizedBox(
                            width: 40,
                            height: 100,
                            child: FAProgressBar(
                              borderRadius: BorderRadius.circular(4),
                              displayText: '%',
                              currentValue: 100 * total * 30 / 1000,
                              verticalDirection: VerticalDirection.up,
                              direction: Axis.vertical,
                              progressColor: const Color.fromARGB(255, 95, 204, 255),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Card(
                            color: const Color.fromARGB(255, 233, 248, 255),
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Center(
                                child: Text(
                                  (total * 30 > 500)
                                      ? '¡Ups! Consumes demasiado'
                                      : (total * 30 > 250)
                                          ? 'Buen trabajo, tu consumo es óptimo'
                                          : 'Felicidades, sigue ahorrando',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Divider(
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Mensual',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '\$ ${getPrice(total * 30).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        currentIndex: 0,
      ),
    );
  }
}
