import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

const tabs = [
  TabInfo(icon: FontAwesomeIcons.image, label: "사진자랑"),
  TabInfo(icon: OctIcons.telescope_16, label: "관측도구"),
  TabInfo(icon: Icons.place, label: "관측장소"),
];
