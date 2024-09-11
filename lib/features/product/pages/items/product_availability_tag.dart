import 'package:flutter/material.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16 / 2),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(12 / 2),
        ),
      ),
      child: const Text(
        "Available in stock",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }
}
