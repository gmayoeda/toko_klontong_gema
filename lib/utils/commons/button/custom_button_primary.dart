import 'package:flutter/material.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
      {super.key, required this.title, required this.action, this.icon});

  final String title;
  final Function action;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      icon: icon ?? const SizedBox(),
      onPressed: () {
        action();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: mainColors,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: Size(MediaQuery.of(context).size.width, 45)),
    );
  }
}
