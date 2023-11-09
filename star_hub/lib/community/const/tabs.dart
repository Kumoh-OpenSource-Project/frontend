import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class TabInfo {
  final IconData icon;
  final String label;
  const TabInfo({required this.icon, required this.label});
}

const TABS = [
  TabInfo(icon: OctIcons.telescope_16, label: "관측도구"),
  TabInfo(icon: Icons.place, label: "관측장소"),
  TabInfo(icon: FontAwesomeIcons.image, label: "사진자랑"),
];

