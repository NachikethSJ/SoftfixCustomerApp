import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

loadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const SizedBox(height: 80),
    ),
  );
}
