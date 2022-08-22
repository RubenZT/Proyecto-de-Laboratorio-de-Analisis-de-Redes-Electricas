import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Device {
  static const types = {
    'Licuadora': CommunityMaterialIcons.blender,
    'Cafetera': CommunityMaterialIcons.coffee_maker,
    'Lavavajillas': CommunityMaterialIcons.dishwasher,
    'Nevera': CommunityMaterialIcons.fridge,
    'Microondas': CommunityMaterialIcons.microwave,
    'Horno': CommunityMaterialIcons.toaster_oven,
    'Tostadora': CommunityMaterialIcons.toaster,
    'Cocina': CommunityMaterialIcons.stove,
    'Batidora': CommunityMaterialIcons.pitchfork,
    'Secadora de Ropa': CommunityMaterialIcons.tumble_dryer,
    'Lavadora de Ropa': CommunityMaterialIcons.washing_machine,
    'Plancha': Icons.iron,
    'Aspiradora': MdiIcons.vacuum,
    'Reproductor DVD': CommunityMaterialIcons.disc_player,
    'TV': CommunityMaterialIcons.television_classic,
    'Consola de Juegos': CommunityMaterialIcons.controller_classic,
    'Aire Acondicionado': CommunityMaterialIcons.air_conditioner,
    'Teléfono Convencional': CommunityMaterialIcons.phone_classic,
    'Ventilador': CommunityMaterialIcons.fan,
    'Ventilador de Techo': MdiIcons.ceilingFan,
    'Grabadora': CommunityMaterialIcons.video,
    'Equipo de Sonido': CommunityMaterialIcons.music,
    'Bombillo de Habitación': CommunityMaterialIcons.lightbulb_on,
    'Lampara': MdiIcons.lamp,
    'Ducha Eléctrica': CommunityMaterialIcons.shower_head,
    'PC de Escritorio': CommunityMaterialIcons.desktop_classic,
    'Laptop': CommunityMaterialIcons.laptop,
    'Impresora': CommunityMaterialIcons.printer,
    'Modem': CommunityMaterialIcons.router_wireless,
    'Tableta': CommunityMaterialIcons.tablet,
    'Bomba de Agua': CommunityMaterialIcons.water_pump,
    'Calentador de Agua': MdiIcons.waterThermometer,
    'Genérico': CommunityMaterialIcons.power_socket_us,
  };

  IconData getIconData() {
    return types[name] ?? CommunityMaterialIcons.power_socket_us;
  }

  int? idx;
  final String name;
  double useTime;
  int quantity;
  double power;
  bool active;

  Device({required this.name, required this.power, this.active = true, required this.useTime, this.idx, required this.quantity});

  static Device fromJson(Map<String, dynamic> json) {
    return Device(
      idx: json['idx'],
      name: json['name'],
      power: json['power'],
      useTime: json['useTime'],
      quantity: json['quantity'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'name': name,
      'power': power,
      'useTime': useTime,
      'quantity': quantity,
      'active': active,
    };
  }
}
