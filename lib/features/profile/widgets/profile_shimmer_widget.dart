import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileShimmer() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}