import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plug/models/device.dart';

class NewDevice extends StatefulWidget {
  final String type;
  const NewDevice({Key? key, required this.type}) : super(key: key);

  @override
  State<NewDevice> createState() => _NewDeviceState();
}

class _NewDeviceState extends State<NewDevice> {
  bool open = false;
  String nombre = '';
  String consumo = '';
  String horas = '';
  String minutos = '';
  String numeroDeEquipos = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (!open) setState(() => open = true)},
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        duration: const Duration(milliseconds: 400),
        height: open ? 360 : 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 205, 239, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      radius: 22,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Device.types[widget.type], size: 32),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.type,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      if (!open) const Icon(MdiIcons.chevronDown),
                    ],
                  ))
                ],
              ),
              if (open) ...[
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 160,
                            child: CupertinoTextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) => consumo = value,
                              textAlign: TextAlign.center,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 32),
                          child: Text('KwH'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Consumo',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 56,
                            child: CupertinoTextField(
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              onChanged: (value) => horas = value,
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                            )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Horas'),
                        ),
                        SizedBox(
                            width: 56,
                            child: CupertinoTextField(
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              onChanged: (value) => minutos = value,
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                            )),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('Minutos'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Tiempo de uso',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 160,
                            child: CupertinoTextField(
                              onChanged: (value) => numeroDeEquipos = value,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                            )),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'N° de equipos',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: () => setState(() => open = false), icon: const Icon(Icons.close)),
                        IconButton(
                            onPressed: () {
                              try {
                                final device = Device(
                                  name: widget.type,
                                  power: double.parse(consumo.replaceAll(',', '.')),
                                  useTime: int.parse(horas) + (int.parse(minutos) / 60.0),
                                  quantity: int.parse(numeroDeEquipos),
                                );

                                final box = GetStorage();

                                final devices = box.read<List>('devices') ?? [];

                                device.idx = devices.length;

                                devices.add(device.toJson());

                                box.write('devices', devices);
                              } catch (e) {
                                print(e);
                                debugPrint('Error al crear nuevo dispositivo');
                              }
                              setState(() => open = false);
                            },
                            icon: const Icon(Icons.check)),
                      ],
                    )
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
